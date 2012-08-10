# 素数を小さい方から6つ並べると 2,  3,  5,  7,  11,  13 であり、6番目の素数は 13 である。
# 10001 番目の素数を求めよ。
def prime?(num, ary)
  for n in ary
    if n <= Math.sqrt(num)
      return false if (num % n).zero?
    else
      break
    end
  end
  return true
end
n = 0
prime_ary = [2, 3, 5]
while  prime_ary.count < 10001
  n += 1
  prime = 6 * n + 1
  if prime?(prime, prime_ary)
    prime_ary.push(prime)
  end
  prime += 4
  if prime?(prime, prime_ary)
    prime_ary.push(prime)
  end
end
p prime_ary[-1]
