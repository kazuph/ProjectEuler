# ピタゴラスの三つ組(ピタゴラスの定理を満たす自然数)とはa<b<cで
# a² + b² = c²
# を満たす数の組である.
# 例えば,  3² + 4² = 9 + 16 = 25 = 5²である.
# a + b + c = 1000となるピタゴラスの三つ組が一つだけ存在する. このa,b,cの積を計算しなさい.
998.downto(3){|c|(c - 1).downto(2){|b|(b-1).downto(1){|a|p a * b * c if a + b + c == 1000 && a**2 + b**2 == c ** 2}}}