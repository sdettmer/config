#!/usr/bin/ruby
# This is Steffens quick source code metrics stats printer.

# See also metric.rb and metric_test.rb.

require 'pp'
require 'yaml'
require 'optparse'

# Older ruby versions don't yet have "reduce(:+)", only inject, let's write
#   a shorthand.
class Array
  # Reducde to sum.
  def sum
     # newer ruby support "reduce(:+)" (for this we would not define
     #    "sum" here at all, because "reduce(:+)" is self-explaintory)
     inject { |sum, n| n.nil? ? sum : sum + n }
  end
end

# Shows statistics according to various views.
#
# As input, the metrics.rb mini tool writes two YAML "database" files:
#   results.yaml (as known from ancient version) containing the source
#   code line count results per system and language (hash of hashes),
#   e.g.
#     one_sys:
#       java: 12345
#       cc: 1234
#     two_sys:
#       java: 4567
#       cc: 1234
# and now also scms.yaml, which looks the same except that instead of
#   system names now it has SCM component names.
#
# Several methods exist to present different sums of the data, for example
# per system, per SCM and per language. Some sources that are (yet) neither
# system nor SCM are internally hard-coded (to be improved as soon as I
# find those sources in CVS :)).
#
# Note: later, scms.yaml could replace results, if we only have the system
# configuration spec file (i.e. now which SCMs compose which system), then
# we can calculate the contents of results.yaml dynamically. At the
# moments, this exactly is what is implemented in metrics.rb.
#
# In next iteration, I think I'll merge both anyway and optionally put
# the "map/reduce" stuff in a module, this could define small functions to
# sum up the different types of elements. This allows giving meaningful
# names to partial operations.
class ShowStats

  attr_accessor :printer

  # Loads file databases
  def initialize(printer = nil)
    @scms      = YAML.load_file("scms.yaml")
    @systotals = YAML.load_file("results.yaml")
    @printer   = printer || lambda { |n,t,d| printf "%s;%s;%s\n", n, t, d }
  end

  def scm_totals
    scmtotals = @scms.values.map { |h| h.values.sum }.sum
    printer.call "SCM components", 0, scmtotals
  end

  def system_totals
    systotals = @systotals.values.map { |h| h.values.sum }.sum
    printer.call "Systems", 0, systotals
  end

  # Shows "Total per system" for each system.
  def total_per_system(&block)
    @systotals.sort.each do | name, linehash |
      output name, 0, linehash.values.sum, &block
    end
  end

  # Shows "Total per component" for each SCM component.
  def total_per_component(&block)
    @scms.sort.each do | name, linehash |
       output name, 0, linehash.values.sum, &block
    end
  end

  # Shows "Total per component" for "big" SCM components.
  def total_per_big_component(&block)
    @scms.sort.each do | name, linehash |
       size = linehash.values.sum
       output name, 0, size, &block if !size.nil? and size > 20000
    end
  end

  def total_per_lang(&block)
    @scms.values.inject { |m, new| m.merge(new) { |k,o,n| o+n } } .
       sort { |a,b| b[1] <=> a[1] } .
       each do | name, size |
          output name, 0, size, &block
       end
  end

  # Shows "Total per system and programming language", which is another way
  #   of saying "Language distribution across systems"
  def total_per_sys_lang(&block)
    @systotals.sort.each do | name, linehash |
       puts "System #{name}"
       linehash.to_a.
       sort { |a,b| b[1] <=> a[1] } [0,10] .
       each { |e| output e[0], 0, e[1], &block }
    end
  end

  # Show "Total and distinct lines per logical component"
  #    (Internally "knows" how to structure and order the output to match
  #    the fields from the excel sheet)
  def all_logical_components

    # Update: Boss also wants the *arithmetical* sum of what *we printed*
    #   We chain printer to sum up what was printed (1:1 solution)
    distinct = 0;
    old_printer = self.printer
    self.printer = lambda { |n,t,d| distinct += d; old_printer.call n, t, d }

    # From excel sheet, section 1
    per_log("A32.de",           "ia32de_sys",
      %w{a32de asn1c_elib cai dll_proxy dumbiso emvlib emvsds
         eolcore eollayer eolmsapp
         hiob host hsm master oai pai pmbc pmcc
         pmng pmsc pmtools poseidon print sdax trace})
    per_log("Database App", "db_app_sys", %w{db_app dbapp db_test})
    per_log("Profile Compiler", "pflc2_sys",  %w{pflc2})

    # section 2
    per_log("CRY.de", "cryde_sys",      %w{hsc_exp_base}) # old cryde
    per_log("MSA.de", "msade_sys",      %w{cryde msa_core msade})
    per_log("BSA.de", "bsade_sys",      %w{bsade bsade_impl bsaif mlt})
    per_log("TSA.de", "tsade_sys",      %w{tsade tsa_master} )
    per_log("SSA.de", "ssade_sys",      %w{ssa_core ssade_pipe})
    per_log("CRY.de Test", "crydetest_sys", %w{crydetest})
    per_log("Crypto Provider",  "crypto_provider_sys", %w{CryptoProvider})

    # section 3
    per_log("EPI", "oem_sys",           %w{oem_impl oemde})
    per_log("EPI Test", "oem_sys",      %w{epi_test epi_test_impl})
    per_log("OAI", nil, %w{oai})

    # section 4
    per_log("GeldKarte", nil,  %w{geplib pmgep})
    per_log("Prepay", nil,  %w{isoprepay pmprepay})
    per_log("CLesss", "clesstest_exp",  %w{cless clesstest martha})

    # section 5
    per_log("MPP32", "mpp_sys",         %w{mpp32 mppde})

    # section 6
    per_log("PPLHost", "pplhost_sys",   %w{pplhost})

    # section 7
    per_log("DSP", "dsp_sys",           %w{dsp stella icorbacomm libodbc++})
    per_log("PDS", "pds_sys",           %w{pds frhscdl ingestore_dl litha})
    per_log("PP-Upgrade", "ppupgrade_sys",   %w{ppupgrade})
    per_log("Testhost", "testhost_sys",
           %w{iso8583_java java_crypto java_parse java_tlv})
    per_log("TAI converter", "tai_converter_sys", %w{tai_converter})
    per_log("AVS Host", "avs_host_sys", %w{avs_host})

    # section 8
    per_log("Building, gensrc", "igdevtools_sys", %w{ingeconf igdevtools})

    # section 9
    per_log("ccommlib", "ccommtest_exp", %w{cbase clog cutils ccomm})
    per_log("Other C++", nil, %w{i++ commtools bintec_capi commtools xxgingel})
    per_log("Other Java", nil, %w{j++ ingestore_dl_java})
    per_log("Other C", nil, %w{gmi os_api sys_mod ccrypt gingel xgingel})
    per_log("ECR Simul", "ecrsimul_sys", %w{ecrsimul})

    # the remaining values that could not automatically calculated from CVS,
    #   values found by mail and various other sources (later: to be
    #   included in YAML database files, then we'll handle them like systems)
    extras = 0
    count_extras = lambda { |e| extras += e; e }
    printer.call "Trition",       0, count_extras.call( 146724 )
    printer.call "MLS Tools",     0, count_extras.call( 6016 )
    printer.call "MessageEditor", 0, count_extras.call( 2158+62+4+6392+8 )
    printer.call "Cerberus",      0, count_extras.call( 23915+2461+4 )
    printer.call "FLM",           0, count_extras.call( 140000 )
    printer.call "STCM",          0, count_extras.call( 28000 )
    printer.call "TestFramework", 0, count_extras.call( 130000 )
    printer.call "chipsim",       0, count_extras.call( 129500 )
    printer.call "SourceForge",   0, count_extras.call( 63172 )
    printer.call "TWiki",         0, count_extras.call( 6222 )

    self.printer = old_printer

    printsep

    # This is a bit ugly, because the view of the excel sheet is not really
    #   clear what to mean as "total". Mathematical correct would be to add
    #   each SCM component PLUS the "remaining values" from above, but it
    #   was explicitely requested to sum the printed values to have the
    #   "Grand total" the sum of all printed "distinct lines". But this
    #   misses some values, namely the components that are not assigned to
    #   any logical system (forgotten in the excel sheet?)
    printer.call "** SUM **",     0, distinct

    # SCM (CVS) totals
    scm_totals

    # Really all are all components plus the "remaining values" from above
    #   (but this is NOT wanted in the excel sheet)
    scmtotals = @scms.values.map { |h| h.values.sum }.sum
    printer.call "Really all",    0, scmtotals + extras
  end



  protected

  # Helper to format numbers into human readable form (e.g. "1,234,123")
  def ShowStats.printNum(num)
    num.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')
  end

  # outputs via block (if any) or @printer
  def output(name, total, distinct, &block)
    if block_given? then
      yield name, total, distinct
    else
      @printer.call name, total, distinct
    end
  end

  # Shows (formats + calculates) output of the "logical components", which
  #   needs a list of "distinct SCMs" which is an (strictly speaking,
  #   arbitrary) association
  def per_log(name, system, scms = [])
    total, distinct = 0, 0
    unless system.nil? then
      # puts "; #{name} (#{system})"
      lines = @systotals[system]
      # no HTML etc
      #pp "lines: ", lines.reject { |k,v| %w{html conf C cpp}.include? k }
      src = lines.reject { |k,v| %w{html conf C cpp}.include? k }
      # extract list of remaining file types
      types = src.keys
      # pp "types:", types
      total = src.values.sum
    end
    if not scms.empty? then
      # for the parameter scms, take them from @scms and reduce to sum.
      distinct = scms.map { |scm| @scms[scm] }.
                      map { |h| h.values.sum }.
                      sum
    end
    printer.call name, total, distinct
  end
  def printsep
    print "-" * 70, "\n"
  end
end

# To simply use in Excel, have a semicolon-separated output format
excel_printer   = lambda { |n,t,d| printf "%s;%s;%s\n", n, t > 0 ? t : d, d }

# Human-readable console output
console_printer = lambda { |name, total, distinct|
  if total > 0
    printf "%-21s Sources: %11s (%9s distinct) lines\n",
      name, ShowStats.printNum(total), ShowStats.printNum(distinct)
    printf "   (%s)\n", types.join(", ") if $VERBOSE
  else
    printf "%-21s Sources:              %9s distinct  lines\n",
      name, ShowStats.printNum(distinct)
  end
}

options = {}
OptionParser.new do | opts |
  opts.banner = "Usage: ./metrics_print.rb [options]"
  opts.separator("  (upper case letters are totals, i.e. one number)")
  opts.separator("Logical view:")
  opts.on("-l", "--logical", "Per/All logical"){ options[:logical] = true }
  opts.on("-L", "--logicals","  (same)")       { options[:logical] = true }
  opts.separator("Techical view (for diagrams only):")
  opts.on("-s", "--systems",  "Per system")    { options[:system] = true }
  opts.on("-S", "--system",   "All systems")   { options[:all_sys] = true }
  opts.on("-c", "--scms",     "Per SCM")       { options[:scm] = true }
  opts.on("-b", "--bigs",     "Per big SCM")   { options[:big_scm] = true }
  opts.on("-C", "--scm",      "All SCMs")      { options[:all_scm] = true }
  opts.separator("Programming Language view (for diagrams only):")
  opts.on("-p", "--proglangs","Per language")  { options[:lang] = true }
  # Sum of "all langs per SCM" and "all SCM per lang" are the same
  opts.on("-P", "--proglang", "All languages") { options[:all_scm] = true }
  opts.on("-x", "--syslang",  "Lang per Sys.") { options[:lang_dist] = true }
  opts.separator("Common options:")
  opts.on("-E", "--excel", "Excel (Sep. `;')") { options[:excel] = true }
  opts.on("-v", "--verbose",  "Verbose")       { $VERBOSE = true }
  opts.on("-d", "--debug",    "Debug mode")    { $DEBUG = true }

  opts.on_tail("-h", "--help", "This help") do
    puts opts
    exit
  end
  opts.on_tail("-V", "--version", "Version information") do
    puts "metrics_print.rb (toybox) 0.0.1"
    exit
  end
end.parse!

puts "verbose" if $VERBOSE;
puts "debug" if $DEBUG;

s = ShowStats.new options[:excel] ? excel_printer : console_printer

s.all_logical_components          if options[:logical]

s.total_per_system                if options[:system]
s.system_totals                   if options[:all_sys]

s.total_per_big_component         if options[:big_scm]
s.total_per_component             if options[:scm]
s.scm_totals                      if options[:all_scm]

s.total_per_lang                  if options[:lang]
s.total_per_sys_lang              if options[:lang_dist]


# Configuration stuff for the emacs editor. Please don't remove
# Local Variables:
# tab-width: 2
# End:
#
# Modeline for VIM. Please don't remove.
# (Help: autoindent, expandtab, shiftwidth=2, tabstop=2, textwidth=75
# vi: set ai et sw=2 ts=2 tw=75:

