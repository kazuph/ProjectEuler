#!/usr/bin/env ruby
# encoding : utf-8
# Problem 21  †
# d(n)をnの真の約数の和と定義する。（真の約数とはn以外の約数のことである。）
# もし、d(a) = b かつ d(b) = a （a ≠ b）を満たすとき、aとbは友愛数（親和数）であるという。
# 例えば、220の約数は1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110なのでd(220) = 284である。
# また、284の約数は1, 2, 4, 71, 142なのでd(284) = 220である。
# それでは10000未満の友愛数の合計を求めよ。
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
    def factor(n)
      factor = []
      count = 1
      while true
        factor << count if n % count == 0
        count += 1
        break if count >= n
      end
      return factor
    end
    def yuai?(num)
      num_factor_sum = factor(num).inject(:+)
      return false if num == num_factor_sum
      num == factor(num_factor_sum).inject(:+)
    end
    # p (1..9999).inject(0){|sum, n|yuai?(n) ? sum + n : sum}
    # p (1..9999).select{|n| yuai?(n)}
    p((1..999).select{|n| yuai?(n)}.inject(:+))

  }
  result[:fast] = x.report("fast ") {
    @target = 0
    @factor_hash = Hash.new(0)
    # 与えられた数で割れるだけ割ってカウント
    def factor (n)
      while true
        if @target % n == 0
          @factor_hash[n]+=1
          @target /= n
        else
          break
        end
      end
    end

    # 素因数分解
    def factorise (num)
      @target = num
      @factor_hash = Hash.new(0)
      # 荒い素数生成器を用いて素因数分解 => 遅い！
      # prime = Prime::Generator23.new

      # 6の倍数±1上にしか素数が存在しない法則を利用
      factor(2)
      factor(3)
      factor(5)
      m = 1
      while true
        n = 6 * m + 1
        break if n * n >  @target
        # 呼ぶと遅いのでfactor使わない
        while true
          if @target % n == 0
            @factor_hash[n]+=1
            @target /= n
          else
            break
          end
        end
        n += 4
        break if n * n >  @target
        # 呼ぶと遅いのでfactor使わない
        while true
          if @target % n == 0
            @factor_hash[n]+=1
            @target /= n
          else
            break
          end
        end
        m += 1
      end
      @factor_hash[@target] += 1 if @target > 1
      # p @factor_hash
      return @factor_hash
    end

    # 与えられた素因数分解の結果より約数の和を計算
    def divisor_num(factor_hash)
      product = 1
      factor_hash.each do |key, value|
        s = 1
        value.times do |num|
          s += key ** (num + 1)
        end
        product  *= s
      end
      return product
    end

    def yuai?(num)
      num_factor_sum = divisor_num(factorise(num)) - num
      return false if num == num_factor_sum
      num == divisor_num(factorise(num_factor_sum)) - num_factor_sum
    end
    # p (1..9999).inject(0){|sum, n|yuai?(n) ? sum + n : sum}
    # p((1..999).select{|n| yuai?(n)})
    p((2..9999).select{|n| yuai?(n)}.inject(:+))

  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
