#!/usr/bin/env ruby
# encoding : utf-8
# Problem 19  †
# 次の情報が与えられている。
# 1900年1月1日は月曜日である。
# 9月、4月、6月、11月は30日まであり、2月を除く他の月は31日まである。 # 2月は28日まであるが、うるう年のときは29日である。
# うるう年は西暦が4で割り切れる年に起こる。しかし、西暦が400で割り切れず100で割り切れる年はうるう年でない。20世紀（1901年1月1日から2000年12月31日）で月の初めが日曜日になるのは何回あるか。
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
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
  }
  result[:fast] = x.report("fast ") {
    def date_adder
      @month += 1
      @day = 1
      if @month > 12
        @month = 1
        @year += 1
      end
    end
    @year = 1900
    @month = 1
    @day = 1
    wday = [1, 2, 3, 4, 5, 6, 0] # 月曜始まり
    count_sunday = 0
    wday.cycle do |wd|
      if @year >= 1901 && @day == 1 && wd == 0
        count_sunday += 1
      end
      break if @year == 2000 && @month == 12 && @day == 1
      @day += 1
      if [4, 6, 9, 11].include?(@month)
        date_adder if @day == 31
      elsif [1, 3, 5, 7, 8, 10, 12].include?(@month)
        date_adder if @day == 32
      elsif @month == 2
        if @year % 4 == 0
          if @year % 400 != 0 && @year % 100 == 0
            date_adder if @day == 29
          else
            date_adder if @day == 30
          end
        else
          date_adder if @day == 29
        end
      end
    end
    p count_sunday
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}





