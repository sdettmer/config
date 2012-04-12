#!/usr/bin/ruby

require 'pp'
require 'yaml'


systotals = YAML.load_file("results.yaml")
  systotals.sort.each do | name, lines_per_lang |
    puts "System #{name}"
    lines_per_lang[0,10].each do | hash |
    type, lines = hash.to_a.flatten
    printf " %10s %12s\n",
        type,
        # http://www.justskins.com/forums/format-number-with-comma-37369.html
        lines.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')
    end
  end
