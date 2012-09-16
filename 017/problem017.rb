#!/usr/bin/env ruby
# encoding : utf-8
# Problem 17  †
# 1 から 5 までの数字を英単語で書けば one, two, three, four, five であり、全部で 3 + 3 + 5 + 4 + 4 = 19 の文字が使われている。
# では 1 から 1000 (one thousand) までの数字をすべて英単語で書けば、全部で何文字になるか。
# 注: 空白文字やハイフンを数えないこと。例えば、342 (three hundred and forty-two) は 23 文字、115 (one hundred and fifteen) は20文字と数える。なお、"and" を使用するのは英国の慣習。

require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
    # 他と組み合わせない系
    first = %w(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen).map(&:length)
    # 他と組み合わせる系
    twent = %w(twenty thirty forty fifty sixty seventy eighty ninety ).map(&:length)
    one = ([""] + %w( one two three four five six seven eight nine)).map(&:length)
    hundredth = "hundred".length
    hundred = "hundredand".length

    number = 0
    one.each do |hund|
      # 100, 200, 300, ...
      if hund != 0
        number += (hund + hundredth)
        hund = hund + hundred
      end

      # 1 ~ 19
      first.each do |fir|
        number += (hund + fir)
      end
      # 20 ~ 99
      twent.each do |twen|
        number += (hund + twen)
        first[0..8].each do |fir|
          number += (hund + twen + fir)
        end
      end
    end
    number += "onethousand".length
    p number
  }
  result[:fast] = x.report("fast ") {
    lens = {0 => 0}

    words_19 = %w(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
    words_19.each_with_index do |num, index|
      lens[index+1]=num.size
    end
    words_10 = %w(twenty thirty forty fifty sixty seventy eighty ninety)
    words_10.each_with_index do |num, index|
      base = (index + 2) * 10
      size = num.size
      lens[base] = size
      1.upto(9) do |pow|
        lens[base+pow] = size + lens[pow]
      end
    end

    sep = 'and'.size
    hundred = 'hundred'.size

    sum = 0

    1.upto(999) do |num|
      if num < 100
        sum+=lens[num]
      else
        hand = hundred + lens[num / 100]
        sum += hand
        remainder = num % 100
        if remainder != 0  #100の倍数
          sum += sep + lens[remainder]
        end
      end
    end

    p sum + 'one'.size + 'thousand'.size
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
