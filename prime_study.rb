# 素因数分解の性質
def factorise(num)
  factors = Hash.new(0)
  n = 1
  while true
    n += 1
    break if n * n > num
    while true
      if num % n == 0
        factors[n] += 1
        num /= n
      else
        break
      end
    end
  end
  factors[num] += 1 if num > 1
  factors
end

primes = []
(1..10000).each do |num|
  primes = primes | factorise(num).keys
end
p primes.sort
