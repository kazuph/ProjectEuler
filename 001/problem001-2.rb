#!/usr/bin/env ruby
require "mathn"
# 10未満の自然数のうち、3 もしくは 5 の倍数になっているものは 3,  5,  6,  9 の4つがあり、 これらの合計は 23 になる。
# 同じようにして、1, 000 未満の 3 か 5 の倍数になっている数字の合計を求めよ。
def sum_while (max, num1, num2)
  n = 0
  sum = 0
  while n < max
    sum += n if n % num1 == 0 || n % num2 == 0
    n += 1
  end
  return sum
end

def sum_inject (max, num1, num2)
  return (1..(max - 1)).inject(0) {|sum, n|
    (n % num1 == 0 || n % num2 == 0) ? sum + n : sum
  }
end

def sum_select_inject (max, num1, num2)
  return (1..(max - 1)).select {|n|n % num1 == 0 || n % num2 == 0}.inject(&:+)
end

require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:while] = x.report("while ") {
    p sum_while(20, 3, 5)
  }
  result[:inject] = x.report("inject ") {
    p sum_inject(1000, 3, 5)
  }
  result[:select_inject] = x.report("select inject ") {
    p sum_select_inject(1000, 3, 5)
  }
  result[:each] = x.report("each ") {
    total = 0
    (1..999).each{|n|total += n if n % 3 == 0 || n % 5 == 0}
    p total
  }
  result[:each] = x.report("each ") {
    total = 0
    (1..999).each{|n|total += n if n % 3 == 0 || n % 5 == 0}
    p total
  }
  result[:sequence] = x.report("sequence ") {
    p( (1000 / 3 * (3 + 999) + 1000 / 5 * (5 + 995) - 1000 / 15 * ( 15 + 990)) / 2)
  }
  result[:sequence_to_i] = x.report("sequence to i ") {
    p( ((1000 / 3.0).to_i * (3 + 999) + (1000 / 5.0).to_i * (5 + 995) - (1000 / 15.0).to_i * ( 15 + 990)) / 2)
  }
  result[:sequence_div] = x.report("sequence div ") {
    p( (1000.div(3) * (3 + 999) + 1000.div(5) * (5 + 995) - 1000.div(15) * (15 + 990)) / 2)
  }
  result[:torii] = x.report("torii ") {
    m = 1000; a1 = 3; a2 = 5
    m = m - 1; a3 = a1 * a2; b1 = (m / a1).to_i; b2 = (m / a2).to_i; b3 = (m / a3).to_i
    p((b1 * (b1 + 1) * a1 + b2 * (b2 + 1) * a2 - b3 * (b3 + 1) * a3) / 2)
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
