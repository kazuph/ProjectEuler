#!/usr/bin/env ruby
# encoding : utf-8
# Problem 25  †
# フィボナッチ数列は以下の漸化式で定義される:
# Fn = Fn-1 + Fn-2, ただし F1 = 1, F2 = 1.
# 最初の12項は以下である.
# F1 = 1
# F2 = 1
# F3 = 2
# F4 = 3
# F5 = 5
# F6 = 8
# F7 = 13
# F8 = 21
# F9 = 34
# F10 = 55
# F11 = 89
# F12 = 14412番目の項, F12が3桁になる最初の項である.
# 1000桁になる最初の項の番号を答えよ.
# t = Time.now
max = 10 ** 999
p (0..1/0.0).inject([1, 1]){|fib, i|
  fib << fib[i] + fib[i + 1]
  break fib if fib[-1] > max
  fib
}.count
# p Time.now - t

# a , b = 1, 1
# count = 2
# while b < max
#   count += 1
#   a , b = b , a + b
# end
# p count

# 一般項を使うぜ
# n = 1
# sqrt5 = Math.sqrt(5)/2.0
# while true
#   fib = ((0.5 + sqrt5)**n - (0.5 - sqrt5)**n)/sqrt5
#   break if fib.to_i.to_s.length >= 1000 # =>  `to_i': Infinity (FloatDomainError)
#   n += 1
# end
# p n
