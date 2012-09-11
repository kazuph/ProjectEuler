#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
result = {}
max = 100000
Benchmark.bm do |x|
  result[:mod] = x.report("modulo ") {
    max.times {max.modulo(3) == 0}
  }
  result[:%] = x.report("% ") {
    max.times {max % 3 == 0}
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.2f" % (value.real * 1000) + "[m]\n"}

