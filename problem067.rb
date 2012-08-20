#!/usr/bin/env ruby
# encoding : utf-8
# Problem 67  †
# 以下の三角形の頂点から下まで移動するとき、その数値の合計の最大値は23になる。
# 37 4
# 2 4 6
# 8 5 9 3
# この例では 3 + 7 + 4 + 9 = 23
# 100列の三角形を含んでいる15Kのテキストファイル triangle.txt (右クリックして、『名前をつけてリンク先を保存』)の上から下まで最大合計を見つけてください。
# 注：これは、Problem 18のずっと難しいバージョンです。
# 全部で299 通りの組み合わせがあるので、この問題を解決するためにすべてのルートをためすことは可能でありません！
# あなたが毎秒1兆本の(1012)ルートをチェックすることができたとしても、全てをチェックするために200億年以上かかるでしょう。
# 解決するための効率的なアルゴリズムがあります。;o)
file = File.open("triangle.txt")
# p @ary = file.each_line.split(/\n/).map{|n|n.split(/ /).map(&:to_i)}
file.close
# @route = []
# # 再帰で辿る
# def search (list, position)
#   if @ary.length == (position[0] + 1)
#     @route << list
#     list = []
#     position = [0, 0]
#     return
#   end
#   (position[1]..(position[1]+1)).each do |m|
#     search(list + [@ary[position[0] + 1][m]], [position[0] + 1, m])
#   end
# end
# search([75], [0, 0])
# p @route.map{|n|n.inject(&:+)}.max
#
