#!/usr/bin/ruby

require 'pp'
require 'yaml'

class Array
  def sum
     inject { |sum, n| sum + n }
  end
end

class ShowStats

  def initialize
    @scms      = YAML.load_file("scms.yaml")
    @systotals = YAML.load_file("results.yaml")
  end

  def showall
    #pp @systotals
    @systotals.sort.each do | name, linehash |
       puts "System #{name}"
       linehash.to_a.
       sort { |a,b| b[1] <=> a[1] } [0,10] .
       each { |e| printf " %10s lines in %s\n", e[1], e[0] }
    end
  end

  def showall2
    @systotals.sort.each do | name, lines_per_lang |
      puts "System #{name}"
      lines_per_lang[0,10].each do | hash |
      type, lines = hash.to_a.flatten
      printf " %10s %12s\n",
          type,
          # http://www.justskins.com/forums/format-number-with-comma-37369.html
          lines.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')
      end
    end
  end

  def showsys
    syssrc("A32.de",           "ia32de_sys", %w{a32de})
    syssrc("Database App",     "db_app_sys", %w{db_app dbapp db_test})
    syssrc("Profile Compiler", "db_app_sys")

    syssrc("BSA.de",           "bsade_sys")
    syssrc("TSA.de",           "tsade_sys")
    syssrc("CRY.de",           "cryde_sys")
    syssrc("SSA.de",           "ssade_sys")
    syssrc("MSA.de",           "msade_sys")
    syssrc("CRY.de Test",      "crydetest_sys")
    syssrc("Crypto Provider",  "crypto_provider_sys")

    syssrc("EPI", "oem_sys", %w{oem_impl oemde})

    syssrc("MPP32", "mpp_sys")

    syssrc("PPLHost", "pplhost_sys")
  end

  protected
  # from {"am"=>185}, returns 185
  def get_lines(hash)
    hash.to_a[1]
  end
  def syssrc(name, system, scms = [])
    # puts "; #{name} (#{system})"
    lines = @systotals[system]
    #pp "lines: ", lines.reject { |k,v| %w{html conf C cpp}.include? k }
    src = lines.reject { |k,v| %w{html conf C cpp}.include? k }
    # extract list of remaining file types
    types = src.keys
    # pp "types:", types
    total = src.values.sum
    distinct = 0
    if not scms.empty? then
      #puts "scms: #{scms}"
      #pp @scms
      #pp "scms", scms
      #pp "with lines", scms.map { |scm| @scms[scm] }
      #pp "with vals", scms.map { |scm| @scms[scm] }.map { |h| h.values }
      distinct = scms.map { |scm| @scms[scm] }.
                      map { |h| h.values.sum }.
                      sum
    end
    printf "%-16s Sources: %11d (%7d distinct) lines\n", name, total, distinct
    printf "   (%s)\n", types.join(", ") if $VERBOSE
  end
end

s = ShowStats.new
s.showsys
#s.showall
#s.showall
