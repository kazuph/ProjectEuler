#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
# フィボナッチ数列の項は前の2つの項の和である。 最初の2項を 1,  2 とすれば、最初の10項は以下の通りである。
#
#  1,  2,  3,  5,  8,  13,  21,  34,  55,  89,  ...
#  数列の項の値が400万を超えない範囲で、偶数値の項の総和を求めよ。
result = {}
MAX = 400_0000
Benchmark.bm do |x|
  result[:inject] = x.report("inject ") {
    def sum_of_even_fib (max)
      return (0..1/0.0).inject([1, 2]){|fib, i|
        fib[i] + fib[i + 1] < max ? fib << fib[i] + fib[i + 1] : (break fib)
      }.select{|n|n % 2 == 0}.inject(&:+)
    end
    # p sum_of_even_fib(10) # => 10
    p sum_of_even_fib(MAX)
  }
  result[:while] = x.report("while ") {
    sum = 0
    a,  b = 1,  1
    while a < MAX
      sum = sum + a if a.even?
      a,  b = a + b,  a
    end
    puts sum
  }
  result[:math] = x.report("math ") {
    n = 1
    fib = 0
    sum = 0
    sqrt5 = Math.sqrt(5)
    fai_puls = (1 + sqrt5) / 2.0
    fai_minus = (1 - sqrt5) / 2.0
    while fib < MAX
      if n % 3 == 0
        sum += fib
        fib = (fai_puls ** n - fai_minus ** n) /sqrt5
      end
      n += 1
    end
    p sum.to_i
  }
  result[:math33] = x.report("math33 ") {
    fib = 0
    sum = 0
    sqrt5 = Math.sqrt(5)
    fai_puls = 0.5 + sqrt5 / 2.0
    fai_minus = 0.5 - sqrt5 / 2.0
    3.step(33, 3) do |n|
      fib = (fai_puls ** n - fai_minus ** n) /sqrt5
      sum += fib
    end
    p sum.to_i
  }
  result[:math_kai] = x.report("math kai") {
    n = 35
    sqrt5 = Math.sqrt(5)
    fai_puls = 0.5 + sqrt5 / 2.0
    fai_minus = fai_puls - sqrt5
    fib = (fai_puls ** n - fai_minus ** n) /sqrt5
    p((fib.to_i - 1) /2)
  }
  result[:math_kai_kai] = x.report("math kai kai") {
    n = 35
    sqrt5 = 2.23606797749979
    fai = 0.5 + sqrt5 / 2.0
    fib = (fai ** n - (-fai) ** (-n)) /sqrt5
    p((fib.to_i - 1) /2)
  }
  result[:bai] = x.report("3bai ") {
    a = 1; b = 2; total = 2
    while (x = 3 * b + 2 * a) <= MAX do
        total += x; a = 2 * b + a; b = x
    end
    p total
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
__END__
ただしここまで気持ち悪く書かなくても以下のページの方法が自然だし単純
http://blog.livedoor.jp/guratan__/archives/3405066.html
```
MAX = 400_0000
sum = 0
a,  b = 1,  1
while a < MAX
  sum = sum + a if a.even?
  a,  b = a + b,  a
end
puts sum
```
