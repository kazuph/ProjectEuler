#!/usr/bin/env ruby
# encoding : utf-8
# Problem 26  †
# 単位分数とは分子が1の分数である。分母が2から10の単位分数を10進数で表記すると次のようになる。
# 1/2 = 0.5
# 1/3 = 0.(3)
# 1/4 = 0.25
# 1/5 = 0.2
# 1/6 = 0.1(6) # 1/7 = 0.(142857)
# 1/8 = 0.125
# 1/9 = 0.(1)
# 1/10 = 0.1
# 0.1(6)は 0.166666... という数字であり、1桁の循環節を持つ。1/7 の循環節は6桁ある。
# d < 1000 なる 1/d の中で循環節が最も長くなるような d を求めよ。
t = Time.now
@ciculator =[]
# 循環数の中に循環数があったら縮める
def make_short
  (@ciculator.count/2).downto(1) do |i|
    n = @ciculator[0..i-1]
    if @ciculator.count % i == 0 && @ciculator.each_slice(i).all?{|m| n == m}
      @ciculator = n
      return
    end
  end
  return
end
# 循環数を求める
def ciculation?(num)
  return false if num.count < 2
  count = num.count
  num.shift if count % 2 != 0
  if num[0..count/2-1] == num[count/2..-1]
    @ciculator = num[0..count/2-1]
    make_short
    return true
  else
    num.shift
    if num && ciculation?(num)
      return true
    else
      return false
    end
  end
end
result = []
(2..999).each do |denominator|
  count = 0
  numerator = 1
  @ciculator = []
  while true
    if denominator > numerator
      numerator *= 10
    end
    @ciculator << numerator / denominator
    numerator -= @ciculator[-1] * denominator
    if numerator == 0
      result << 1 # 割り切れたということは循環小数は0
      break
    elsif (@ciculator.count >= 2* (denominator - 1)) && ciculation?(Marshal.load(Marshal.dump(@ciculator)))
      result << @ciculator.count
      break
    end
  end
end
p result.index(result.max)+2
p Time.now - t
