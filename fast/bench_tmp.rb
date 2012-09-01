#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
  }
  result[:slow] = x.report("slow ") {
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.2f" % (value.real * 1000) + "[m]\n"}

