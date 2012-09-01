#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
max = 10_000_000
result = {}
Benchmark.bm do |x|
  result[:for] = x.report("for ") {
    ary = []
    for count in 0..max
      ary << count
    end
    p ary[-1]
  }
  result[:each] = x.report("each ") {
    ary = []
    (0..max).each do |count|
      ary << count
    end
    p ary[-1]
  }
  result[:times] = x.report("times ") {
    ary = []
    (max + 1).times do |count|
      ary << count
    end
    p ary[-1]
  }
  result[:while] = x.report("while ") {
    ary = []
    count = 0
    while count <= max
      ary << count
      count += 1
    end
    p ary[-1]
  }
  result[:loop] = x.report("loop ") {
    ary = []
    count = 0
    loop do
      if count <= max
        ary << count
        count += 1
      else
        break
      end
    end
    p ary[-1]
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.2f" % value.real + "[sec]\n"}
