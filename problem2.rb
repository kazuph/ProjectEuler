# フィボナッチ数列の項は前の2つの項の和である。 最初の2項を 1,  2 とすれば、最初の10項は以下の通りである。
#
#  1,  2,  3,  5,  8,  13,  21,  34,  55,  89,  ...
#  数列の項の値が400万を超えない範囲で、偶数値の項の総和を求めよ。
def sum_of_even_fib (max)
  return (0..1/0.0).inject([1, 2]){|fib, i| fib[i] + fib[i + 1] < max ? fib << fib[i] + fib[i + 1] : (break fib)}.select{|n|n % 2 == 0}.inject(0){|sum, n| sum + n}
end
p sum_of_even_fib(10) # => 10
p sum_of_even_fib(4_000_000) # => 350704366
