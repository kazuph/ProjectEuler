#!/usr/bin/env ruby
# encoding : utf-8
# Problem 24  †
# 順列とはモノの順番付きの並びのことである. たとえば, 3124は数1, 2, 3, 4の一つの順列である. すべての順列を数の大小でまたは辞書式に並べたものを辞書順と呼ぶ.  0と1と2の順列を辞書順に並べると
# 012 021 102 120 201 210
# になる.
# 0,1,2,3,4,5,6,7,8,9からなる順列を辞書式に並べたときの100万番目を答えよ

require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
    count = 0
    (0..9).to_a.permutation do |n|
      count += 1
      if count == 1_000_000
        p n.join.to_i
      end
    end
  }
  result[:fast] = x.report("fast ") {
    rest = 1_000_000 - ( 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 ) * 2
    p ([0,1,3,4,5,6,7,8,9].permutation(9).map{|a| 2.to_s + a.join('')}.sort)[rest -1]
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
