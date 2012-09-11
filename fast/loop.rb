#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
max = 10_000_000
result = {}
Benchmark.bm do |x|
  result[:for] = x.report("for ") {
    ary = [0]
    count = nil
    for count in 0..max
      ary << (ary[-1] + 1)
    end
    p ary[-1]
  }
  result[:each] = x.report("each ") {
    ary = [0]
    (0..max).each do
      ary << (ary[-1] + 1)
    end
    p ary[-1]
  }
  result[:times] = x.report("times ") {
    ary = [0]
    (max + 1).times do
      ary << (ary[-1] + 1)
    end
    p ary[-1]
  }
  result[:while] = x.report("while ") {
    ary = [0]
    while ary[-1] < max
      ary << (ary[-1] + 1)
    end
    p ary[-1]
  }
  result[:loop] = x.report("loop ") {
    ary = [0]
    loop do
      if ary[-1] < max
        ary << (ary[-1] + 1)
      else
        break
      end
    end
    p ary[-1]
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.2f" % value.real + "[sec]\n"}
