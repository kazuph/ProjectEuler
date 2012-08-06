# 13195 の素因数は 5、7、13、29 である。
# 600851475143 の素因数のうち最大のものを求めよ。
# 素因数分解
def factorization (num)
  factor = []
  factor << 2 if num % 2 == 0
  factor << 3 if num % 3 == 0
  (4..num).each do |prime|
    if !(2..Math.sqrt(prime)).any?{|n| prime % n == 0}
      p factor << prime if num % prime == 0
      if factor.inject(1) {|p, i| p * i} == num
        break
      end
    end
  end
  # p factor
end
factorization(13195)
factorization(600851475143)

