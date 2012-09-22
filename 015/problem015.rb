# Problem 15  †
# 2 × 2 のマス目の左上からスタートした場合、引き返しなしで右下にいくルートは 6 つある。
# では、20 × 20 のマス目ではいくつのルートがあるか。
require 'benchmark'
result = {}
Benchmark.bm do |x|
  result[:slow] = x.report("slow ") {
    num = 20
    def fact(n)
      (1..n).inject(&:*)
    end
    p fact(num * 2)/(fact(num)** 2)
  }
  result[:fast] = x.report("fast ") {
    p((21..40).inject(&:*) / (1..20).inject(&:*))
  }
end
result.sort_by{|key, value| value.real}.map{|key, value| print "code : #{key} = " + "%0.4f" % (value.real * 1000) + "[msec]\n"}
