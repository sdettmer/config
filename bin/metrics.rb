#!/usr/bin/ruby

require 'pp'
require 'yaml'

def checkout(system)
  begin
    puts "checking out #{system}"
    cvsout = IO.read "|cvs co #{system} 2>&1"
    if $? != 0 then raise "cvs failed" end
    puts "prepare -ro #{system}"
    prepareout = IO.read "| cd #{system} 2>&1 && ./prepare -ro 2>&1"
    if $? != 0 then raise "prepare failed" end
  rescue
    puts "** error **"
    puts case
      when prepareout : "prepare:\n" + prepareout
      when cvsout     : "cvs:\n" + cvsout
      else "unknow problem"
    end
    puts "** abort **"
    raise
  end
  begin
  rescue
    puts prepareout
    puts "** abort **"
    raise
  end
end

# Returns [ "system_sys/ingeconf/.", ... ]
def get_scms(system)
  Dir.glob("#{system}/*/.").
      reject {|d| /(build|admin|CVS|telium_platform|u32_platform)/ =~ d }.
      reject {|d| /ssade\// =~ d }.
      # "the basename of the dirname":
      #  we first drop "/." using dirname, then only use last component
      map {|v| File.basename(File.dirname(v)) }
      # same with regex:
      # map {|v| /.*?([^\/]+)(\/?.?)$/ =~ v && $1 }
end

def metrics(system, component)
  files = IO.readlines("| find #{system}/#{component} -type f").
             map!   { |l| l.chomp }.
             reject { |f| /(CVS|pdf$)/ =~ f }.
             select { |f| /[.](h|c|pm|xml|java|in|txt|am|pl|pm|m4|sh|mak|am|cc|mki|html|cpp|sql|sh|C|asn1|ini|conf)$/ =~ f }

  lines_per_lang = Hash.new
  puts "  #{component} (of #{system}): #{files.size} files..."
  puts "files: " + files.join(", ") + " (files end)" if $DEBUG
  files.each do |f|
     ext = "others"
     /[.]([^.]+)$/ =~ f and ext = $1
     srclines, file = IO.read("| wc -l '#{f}'").split(/\s+/)
     puts "file #{ext} += #{srclines} (#{file})" if $DEBUG
     lines_per_lang[ext] ||= 0
     lines_per_lang[ext] += Integer(srclines || 0)
  end #lines_per_lang
  puts "COMPONENT RESULTS #{component} (of #{system})" if $DEBUG
  pp lines_per_lang if $DEBUG
  #lines_per_lang.each { |lang, lines| puts "lpl: #{lang} = #{lines}" }
  #raise "xx"
  #10
  lines_per_lang
end

File.open "systems.lst" do | file |
  puts "file: " + file.path
  # takes lines per SCMs (with cache)
  # lines ||= Hash.new
  lines     = { }
  types     = [ ]
  systotals = { }

  systems = file.readlines
  systems.each do | sysname |
    sysname.strip!
    next if /^[#;]/ =~ sysname or sysname.empty? # skip comments
    puts " - " + sysname

    checkout sysname unless File.exists? sysname
    scms = get_scms sysname
    puts "SCMs: " + scms.join(", ")

    scms.each do | scm |
      # lines[scm] = { :c => 100, :h=>50 }
      if lines[scm] then
        puts "already have #{scm}" if $DEBUG
        next
      end
      lines_per_lang = metrics sysname, scm
      lines_per_lang.each { |s, l| types << s unless types.include? s }
      lines[scm] ||= lines_per_lang
    end
    puts "** LINES COMPONENTS TOTALS AFTER #{sysname}:" if $DEBUG
    pp lines if $DEBUG

    # map / reduce all results

    #lines.each { |s, l| puts "Lines: #{s} = #{l}" }
    #puts "types: " + types.join(",")

    # map / reduce
    counts = types.map do | type |
      # old ruby does not have reduce(:+), so we use inject:
      lines.select { | scmname, val | scms.include? scmname } .
            map    { | scmname, val | Integer(val[type] || 0) } .
            inject { | sum, n |       sum + n }
    end
    puts "** COUNTS TOTALS AFTER #{sysname}:" if $DEBUG
    pp counts if $DEBUG
    puts "** RESULT TOTALS FOR #{sysname}:"
    # lines.select would be better than reject-not, but select
    #                                         returns an array, not a hash!!
    # pp "smcs", lines.reject { | scmname, val | not scms.include? scmname }
    pp "scms.v.r", lines.reject { | scmname, val | not scms.include? scmname }.
                   values.
                   inject { |m, new| m.merge(new) { |k,o,n| o+n } } if $DEBUG
    systotals[sysname] = lines.
      reject { | scmname, val | not scms.include? scmname }.
      values.
      inject { |sums, new| sums.merge(new) { |k,o,n| o+n } }
  end

  File.open("scms.yaml",    "w") { |f| YAML.dump(lines, f) }
  File.open("results.yaml", "w") { |f| YAML.dump(systotals, f) }
end
