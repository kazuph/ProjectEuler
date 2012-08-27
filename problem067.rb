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
File.open("triangle.txt") do |file|
  @ary = file.each_line.map{|line| line.chomp!.split(/ /).map(&:to_i)}
end
# ルート検索をするのではなく下から順に大きい方を加算していく
(@ary.length - 2).downto(0) do |j|
  @ary[j].each_index do |i|
    @ary[j][i] += @ary[j + 1][i..(i+1)].max
  end
  @ary.pop
  # @ary.map{|row|p row}
end
p @ary[0][0]
