#!/usr/bin/env ruby
# encoding : utf-8
# Problem 26  †
# 単位分数とは分子が1の分数である。分母が2から10の単位分数を10進数で表記すると次のようになる。
# 1/2 = 0.5
# 1/3 = 0.(3)
# 1/4 = 0.25
# 1/5 = 0.2
# 1/6 = 0.1(6)
# 1/7 = 0.(142857)
# 1/8 = 0.125
# 1/9 = 0.(1)
# 1/10 = 0.1
# 0.1(6)は 0.166666... という数字であり、1桁の循環節を持つ。1/7 の循環節は6桁ある。
# d < 1000 なる 1/d の中で循環節が最も長くなるような d を求めよ。
require "pp"
t = Time.now
# 素因数分解
def factorization (num)
  origin = num
  max = 0
  # 2, 3, 5
  [2, 3, 5].each do |prime|
    break if prime * prime > num
    if num % prime == 0
      max = prime
      num /= prime
    end
    return max if num == 1
  end
  # 7以降の素数候補で割る
  n = 0
  while true
    n += 1
    prime = 6 * n + 1
    break if prime * prime > num
    if num % prime == 0
      max = prime
      num /= prime
    end
    prime += 4
    break if prime * prime > num
    if num % prime == 0
      max = prime
      num /= prime
    end
  end
  max = num if origin == num
  return max
end
result = []
(2..999).each do |denominator|

  if denominator % 2 == 0 || denominator % 5 == 0
    result << 1
  else
    p [denominator, factorization(denominator)]
    # result << (factorization(denominator) - 1)
  end
end
pp result
p result.max
p Time.now - t
