#!/usr/bin/env ruby
# encoding : utf-8
# Problem 44  †
# 五角数は Pn = n(3n-1)/2で生成される. 最初の10項は
# 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
# である.
# P4 + P7 = 22 + 70 = 92 = P8である. しかし差 70 - 22 = 48は五角数ではない.
# 五角数のペア PjとPkについて, 差と和が五角数になるものを考える. 差を D = |Pk - Pj| と書く. 差 D の最小値を求めよ.
def gokaku (n)
  return n * (3 * n - 1) / 2
end
gokaku_nums = [1, 5]
diff = 0
sum = 0
index = 0
catch(:finish){
  while true
    index += 1
    (index - 1).downto(0) do |i|
      gn = gokaku_nums[i]
      diff = gokaku_nums[index] - gn
      sum = gokaku_nums[index] + gn
      while gokaku_nums[-1] < sum
        gokaku_nums << gokaku(gokaku_nums.count + 1)
      end
      p [index, gokaku_nums[index], gn, diff, sum, gokaku_nums.include?(diff), gokaku_nums.include?(sum)]
      # p gokaku_nums
      if gokaku_nums.include?(sum) && gokaku_nums.include?(diff)
      # if gokaku_nums.include?(sum)
        p diff
        p sum
        p gokaku_nums[index]
        p gn
        throw :finish
      end
    end
  end
}

