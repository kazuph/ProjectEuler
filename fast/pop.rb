#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
max = 1_000
Benchmark.bm do |x|
  x.report(" | ") {
    ary = []
    count = 0
    while count <= max
      ary = ary | [count]
      count += 1
    end
    p ary[-1]
  }
  x.report(" + ") {
    ary = []
    count = 0
    while count <= max
      ary = ary + [count]
      count += 1
    end
    p ary[-1]
  }
  x.report("<<") {
    ary = []
    count = 0
    while count <= max
      ary << count
      count += 1
    end
    p ary[-1]
  }
  x.report("push") {
    ary = []
    count = 0
    while count <= max
      ary.push(count)
      count += 1
    end
    p ary[-1]
  }
end

