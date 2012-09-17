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
require 'pp'
t = Time.now
@ciculator =[]
# 循環数の中に循環数があったら縮める
def make_short num
  (1..(@ciculator.count/2)).each do |i|
    n = @ciculator[0..i-1]
    if @ciculator.count % i == 0 &&  @ciculator.each_slice(i).all?{|num| n == num}
      @ciculator = n
      return
    end
  end
  return
end
# 循環数を求める
def ciculation?(num)
  return false if num.count < 2
  # p "in ciculation?"
  # p num
  count = num.count
  num.shift if count % 2 != 0
  if num[0..count/2-1] == num[count/2..-1]
    @ciculator = num = num[0..count/2-1] || nil
    if num
      make_short num
      return true
    else
      return false
    end
  else
    num.shift
    if num != nil && ciculation?(num)
      if num
        make_short num
        return true
      else
        return false
      end
      @ciculator = num
      return true
    else
      return false
    end
  end
end
max_length = 0
ans = ""
result = []
# (7..7).each do |denominator|
(2..999).each do |denominator|
  count = 0
  p [denominator, "hoge"]
  numerator = 1
  @ciculator = []
  while true
    if denominator > numerator
      numerator *= 10
    end
    @ciculator << (numerator / denominator.to_f).to_i
    numerator -= @ciculator[-1] * denominator
    if numerator == 0
      result << "0".length # 割り切れたということは循環小数は0
      break
    #elsif @ciculator.count >= (denominator - 1) && (count += 1) >= 0 && ciculation?(@ciculator)
    elsif @ciculator.count > 1 && (count += 1) >= 0 && ciculation?(Marshal.load(Marshal.dump(@ciculator)))
      # p count
      p @ciculator
      if result.max < @ciculator.join.length
        ans = @ciculator.join
      end
      result << @ciculator.join.length
      break
    end
  end
end
puts
pp result
p result.max
p ans
p Time.now - t
