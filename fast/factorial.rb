#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'

result = {}
Benchmark.bm do |x|
  result[:**] = x.report("** ") {
    p 2 ** 1000
  }
  result[:times] = x.report("times ") {
    r = 1
    1000.times{r *= 2}
    p r
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
