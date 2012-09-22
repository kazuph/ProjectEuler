#!/usr/bin/env ruby
# encoding : utf-8
# Problem 18  †
# 以下の三角形の頂点から下まで移動するとき、その数値の合計の最大値は23になる。
# 37 4
# 2 4 6
# 8 5 9 3
# この例では 3 + 7 + 4 + 9 = 23
# 以下の三角形を頂点から下まで移動するとき、その最大の合計値を求めよ。
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:fast] = x.report("fast ") {
pyramid = <<EOL.split(/\r\n|\r|\n/).select{|str|str.size>0}.map{|str|str.split(' ').map(&:to_i)}
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
EOL
pr = [pyramid[0]]
before = pyramid[0]
1.upto(pyramid.size - 1) do |idx|
  ary = pyramid[idx]
  ary_size = ary.size
  pry = [before[0]+ary[0]]
  1.upto(ary_size-2) do |i|
    b_num1 = before[i-1]
    b_num2 = before[i]
    pry << ary[i] + (b_num1 > b_num2 ? b_num1 : b_num2)
  end
  pry << before[before.size-1]+ary[ary_size-1]
  pr << pry
  before = pry
end
p pr[pr.size-1].max
  }
  result[:slow] = x.report("slow ") {
ary =<<EOF.each_line.map{|n| n.split(/ /).map(&:to_i)}
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
EOF
    (ary.size - 2).downto(0) do |j|
      ary[j].each_index do |i|
        ary[j][i] += ary[j + 1][i] > ary[j+1][i+1] ? ary[j+1][i] : ary[j+1][i+1]
      end
    end
    p ary[0][0]
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
