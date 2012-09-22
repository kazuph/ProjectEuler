#!/usr/bin/env ruby
# encoding : utf-8
# Problem 21  †
# d(n)をnの真の約数の和と定義する。（真の約数とはn以外の約数のことである。）
# もし、d(a) = b かつ d(b) = a （a ≠ b）を満たすとき、aとbは友愛数（親和数）であるという。
# 例えば、220の約数は1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110なのでd(220) = 284である。
# また、284の約数は1, 2, 4, 71, 142なのでd(284) = 220である。
# それでは10000未満の友愛数の合計を求めよ。
def factor(n)
  factor = []
  count = 1
  while true
    factor << count if n % count == 0
    break if 2 * count >= n
    count += 1
  end
  return factor
end
def yuai?(num)
  num_factor_sum = factor(num).inject(:+)
  return false if num == num_factor_sum
  num == factor(num_factor_sum).inject(:+)
end
# p (1..9999).inject(0){|sum, n|yuai?(n) ? sum + n : sum}
# p (1..9999).select{|n| yuai?(n)}
p (1..9999).select{|n| yuai?(n)}.inject(:+)

