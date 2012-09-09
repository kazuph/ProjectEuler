#!/usr/bin/env ruby
# encoding : utf-8
# Problem 19  †
# 次の情報が与えられている。
# 1900年1月1日は月曜日である。
# 9月、4月、6月、11月は30日まであり、2月を除く他の月は31日まである。
# 2月は28日まであるが、うるう年のときは29日である。
# うるう年は西暦が4で割り切れる年に起こる。しかし、西暦が400で割り切れず100で割り切れる年はうるう年でない。20世紀（1901年1月1日から2000年12月31日）で月の初めが日曜日になるのは何回あるか。
require 'date'
# ずるい方法
date = Date.new(1901,  1 , 1)
end_date = Date.new(2000, 12, 31)
count = 0
while end_date >= date
  if date.day == 1 && date.wday == 0
    count += 1
  end
  date = date + 1
end
p count





