#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
# Problem 18  †
# 以下の三角形の頂点から下まで移動するとき、その数値の合計の最大値は23になる。
# 37 4
# 2 4 6
# 8 5 9 3
# この例では 3 + 7 + 4 + 9 = 23
# 以下の三角形を頂点から下まで移動するとき、その最大の合計値を求めよ。
data =<<Data
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
Data
# 注: ここではたかだか 16384 通りのルートしかないので、すべてのパターンを試すこともできる。Problem 67 は同じ問題だが100行あるので、総当りでは解けない。もっと賢い方法が必要である。
Benchmark.bm do |x|
  x.report(" saiki ") {
    @ary = data.split(/\n/).map{|n|n.split(/ /).map(&:to_i)}
    @route = []
    # 再帰で辿る
    def search (list, position)
      if @ary.length == (position[0] + 1)
        @route << list
        list = []
        position = [0, 0]
        return
      end
      (position[1]..(position[1]+1)).each do |m|
        search(list + [@ary[position[0] + 1][m]], [position[0] + 1, m])
      end
    end
    search([75], [0, 0])
    p @route.map{|n|n.inject(&:+)}.max
  }
  x.report(" sum ") {
    @ary = data.split(/\n/).map{|n| n.split(/ /).map(&:to_i)}
    (@ary.length - 2).downto(0) do |j|
      @ary[j].each_index do |i|
        @ary[j][i] += @ary[j + 1][i..(i+1)].max
      end
      @ary.pop
      # @ary.map{|row|p row}
    end
    p @ary[0][0]
  }
  x.report(" sum no pop") {
    ary = data.each_line.map{|n| n.split(/ /).map(&:to_i)}
    (ary.length - 2).downto(0) do |j|
      ary[j].each_index do |i|
        ary[j][i] += ary[j + 1][i..(i+1)].max
      end
      # @ary.map{|row|p row}
    end
    p ary[0][0]
  }
  x.report(" sum no pop and while") {
    ary = data.each_line.map{|n| n.split(/ /).map(&:to_i)}
    j = ary.length - 2
    while j >= 0
      ary[j].each_index do |i|
        ary[j][i] += ary[j + 1][i..(i+1)].max
      end
      j -= 1
      # ary.pop
      # ary.map{|row|p row}
    end
    p ary[0][0]
  }
  x.report(" sum pop and while") {
    ary = data.each_line.map{|n| n.split(/ /).map(&:to_i)}
    while ary.length > 1
      ary[-2].each_index do |i|
        ary[-2][i] += ary[-1][i..(i+1)].max
      end
      ary.pop
      # ary.map{|row|p row}
    end
    p ary[0][0]
  }
end

