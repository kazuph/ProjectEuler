#!/usr/bin/env ruby
# encoding : utf-8
require 'benchmark'
# 13195 の素因数は 5、7、13、29 である。
# 600851475143 の素因数のうち最大のものを求めよ。
result = {}
Benchmark.bm do |x|
  result[:normal] = x.report("normal ") {
    # 素因数分解
    def factorization (num)
      factor = []
      # 素数を生成して順に割っていく
      (2..num).each do |prime|
        # 素数の判定
        if !(2..Math.sqrt(prime)).any?{|n| prime % n == 0}
          # 素数で割り切れたら追加
          factor << prime if num % prime == 0
          # 割り切れた素数の積が元の数に等しいなら終了
          if factor.inject(&:*)  == num
            break
          end
        end
      end
      return factor
    end
    p factorization(600851475143).max
  }
  result[:normal_kai] = x.report("normal kai ") {
    # 素因数分解
    def factorization (num)
      factor = []
      # 素数を生成して順に割っていく
      prime = 2
      while true
        # 素数の判定
        if !(2..Math.sqrt(prime)).any?{|n| prime % n == 0}
          # 素数で割り切れたら追加
          if num % prime == 0
            factor << prime
            # ここ重要
            # 素因数が見つかったら次のループからは素因数で割った数を判定
            # たんだん小さくなっていくのでループ回数がかなり減る
            num /= prime
          end
        end
        prime += 1
        # 割る数の2乗がそもそも割られる数よりも大きいのならもうやる必要はない
        # numが小さくなっていくのでbreakするのも早い
        break if  prime * prime > num
      end
      # 与えられた数が素数だった場合
      # つまり上記のループで一度も割られていない場合は素数であり素因数は自分自身のみ
      factor << num
      return factor
    end
    p factorization(600851475143).max
  }
  result[:fast] = x.report("fast ") {
    def factorization (num)
      factor = []
      # 2, 3, 5
      [2, 3, 5].each do |prime|
        num % prime == 0 && factor << prime && num /= prime
      end
      # 7以降の素数候補で割る
      n = 0
      while true
        n += 1
        # 6の倍数±1だけが素数である可能性がある
        # そもそも割れなかったら素数じゃないのでそれが判定みたいなもん
        # なので素数の判定を外したら爆速になった
        prime = 6 * n + 1
        break if prime * prime > num
        # 一行にしたことに・・・深い意味は無い・・・
        num % prime == 0 && factor << prime && num /= prime

        prime += 4
        break if prime * prime > num
        num % prime == 0 && factor << prime && num /= prime
      end
      factor << num
      return factor
    end
    p factorization(600851475143).max
  }
  result[:more_fast] = x.report("more fast ") {
    # 最大の素因数が求まればいいので配列に入れるのをやめた
    # がそんなに速くはならなかった
    def factorization (num)
      origin = num
      max = 0
      # 2, 3, 5
      [2, 3, 5].each do |prime|
        break if prime * prime > num
        if num % prime == 0
          max = prime
          num /= prime
        end
        return max if num == 1
      end
      # 7以降の素数候補で割る
      n = 0
      while true
        n += 1
        prime = 6 * n + 1
        break if prime * prime > num
        if num % prime == 0
          max = prime
          num /= prime
        end
        prime += 4
        break if prime * prime > num
        if num % prime == 0
          max = prime
          num /= prime
        end
      end
      max = num if origin == num
      return max
    end
    p factorization(600851475143)
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.2f" % (value.real * 1000) + "[msec]\n"}
# =>
# code : more_fast = 0.16[msec]
# code : fast = 0.16[msec]
# code : normal_kai = 10.10[msec]
# code : normal = 65.64[msec]

__END__
# 素因数分解
def factorization (num)
  factor = []
  # 素数を生成して順に割っていく
  (2..num).each do |prime|
    if !(2..Math.sqrt(prime)).any?{|n| prime % n == 0}
      # 素数で割り切れたら追加
      factor << prime if num % prime == 0
      # 割り切れた素数の積が元の数に等しいなら終了
      if factor.inject(&:*)  == num
        break
      end
    end
  end
  return factor
end
# p factorization(13195) # => [5, 7, 13, 29]
# p factorization(600851475143)
p factorization(13195).max # => 29
p factorization(600851475143).max
