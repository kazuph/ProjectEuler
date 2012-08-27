# ピタゴラスの三つ組(ピタゴラスの定理を満たす自然数)とはa<b<cで
# a² + b² = c²
# を満たす数の組である.
# 例えば,  3² + 4² = 9 + 16 = 25 = 5²である.
# a + b + c = 1000となるピタゴラスの三つ組が一つだけ存在する. このa,b,cの積を計算しなさい.
t = Time.now
catch(:finish) {
  998.downto(3){|c|
    (1000 - c - 1).downto(2){|b|
      # c とbが決まればaは一意に決まる
      a = 1000 - b - c
      break if a >= b
      if a*a + b*b == c*c
        p a * b * c
        throw :finish
      end
    }
  }
}
p ((Time.now - t)*1000).to_i
