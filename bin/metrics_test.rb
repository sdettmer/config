#!/usr/bin/ruby

require 'test/unit'
require 'pp'

class TestMapReduce < Test::Unit::TestCase

  def test_one
    scms = makehash
    assert(scms[:cbase][:c] == 10000)
    assert(scms[:ccomm][:h] == 10000)
    #puts scms[:cbase]
    res = [:c, :h].map do | type |
      #puts "type #{type}"
      #scms.map { | scm | puts (scms[scm])[type] }
      res2 = scms.map    { | name, val | Integer(val[type]) } .
                  inject { | sum, n |    sum + n }
      #puts "type #{type} -> res2 == #{res2}"
      res2
    end
    #pp [:c, :h], res
    assert_equal(res[0], 30000); # :c
    assert_equal(res[1], 15000); # :h
  end

  def test_arrays_to_hash
    ref  = {:c => 1000, :h => 500}
    keys = [:c, :h]
    vals = [1000, 500]
    hash = Hash[*keys.zip(vals).flatten]
    assert_equal(hash, ref)
  end

  def test_mapreduce
    ref    = { :h => 15000, :c => 30000 }
    lines  = makehash
    types  = [:c, :h]
    counts = types.map do | type |
       lines.map    { | name, val | Integer(val[type]) } .
             inject { | sum, n |    sum + n }
    end
    results = Hash[*types.zip(counts).flatten]
    assert_equal(ref, results)
  end

  def test_first_three
    ref       = [["c", 1419018],
                  ["h", 462876],
                  ["doc", 222055]]
    systotals = [["c", 1419018],
                  ["h", 462876],
                  ["doc", 222055],
                  ["pm", 209646],
                  ["java", 198245],
                  ["cc", 183473]]

    first = systotals[0,3]

    assert_equal(ref, first)
  end

  def test_more_than_100
    ref       = [["c", 1419018],
                  ["doc", 222055],
                  ["cc", 183473]]

    systotals = [["c", 1419018],
                  ["h", 46],
                  ["doc", 222055],
                  ["java", 12],
                  ["cc", 183473]]

    bigger = systotals.select { |f| f[1] > 99 }

    assert_equal(ref, bigger)
  end

  private
  def makehash
    { :cbase => { :c => 10000, :h =>  5000 },
      :ccomm => { :c => 20000, :h => 10000 },
    }
  end
end

