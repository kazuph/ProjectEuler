#!/usr/bin/env ruby
# encoding : utf-8
# Problem 16  †
# 2^15 = 32768 であり、これの各数字の合計は 3 + 2 + 7 + 6 + 8 = 26 となる。
# 同様にして、2^1000 の各数字の合計を求めよ。
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
    p((2 ** 1000).to_s.split(//).map(&:to_i).inject(&:+))
  }
  result[:fast] = x.report("fast ") {
    p((2**1000).to_s.each_byte.inject(0){|sum, byte| sum + byte - 48})
  }
  result[:yama] = x.report("yama ") {
    sum = 0
    (2**1000).to_s.each_byte{|byte| sum+=byte-48}
    p sum
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
