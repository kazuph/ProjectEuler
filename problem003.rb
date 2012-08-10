# 13195 の素因数は 5、7、13、29 である。
# 600851475143 の素因数のうち最大のものを求めよ。

# 素因数分解
def factorization (num)
  factor = []
  # 素数を生成して順に割っていく
  factor << 2 if num % 2 == 0
  factor << 3 if num % 3 == 0
  (4..num).each do |prime|
    if !(2..Math.sqrt(prime)).any?{|n| prime % n == 0}
      # 素数で割り切れたら追加
      factor << prime if num % prime == 0
      # 割り切れた素数の積が元の数に等しいなら終了
      if factor.inject(1) {|p, i| p * i} == num
        break
      end
    end
  end
  return factor
end
# p factorization(13195) # => [5, 7, 13, 29]
# p factorization(600851475143) # => [71, 839, 1471, 6857]

# 最大のものっていう指定を忘れていた
p factorization(13195).max # => 29
p factorization(600851475143).max # => 6857
