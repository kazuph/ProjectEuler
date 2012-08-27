#!/usr/bin/env ruby
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

# while文を使って書いてみる
p sum_while(10, 3, 5) # => 23
p sum_while(1000, 3, 5)

# inject文を使って書いてみる
p sum_inject(10, 3, 5) # => 23
p sum_inject(1000, 3, 5)

# select文もかませたinject文を使って書いてみる
p sum_select_inject(10, 3, 5) # => 23
p sum_select_inject(1000, 3, 5)

# ワンライナー
# $ ruby -e 'p (1..999).select{|n|n%3==0||n%5==0}.inject(:+)'
