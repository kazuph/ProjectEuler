#!/usr/bin/env ruby
# encoding : utf-8
# Problem 39  †
# 辺の長さが{a,b,c}と整数の3つ組である直角三角形を考え, その周囲の長さをpとする.
# p = 120のときには3つの解が存在する:
# {20,48,52}, {24,45,51}, {30,40,50}
# p ≦ 1000 で解の数が最大になる p を求めよ.
(3..999).each do |p|
  (1..p).each do |a|
    (1..p).each do |b|
      c = p - a - b
    end
  end
end
