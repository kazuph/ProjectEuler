# 左右どちらから読んでも同じ値になる数を回文数という。 2桁の数の積で表される回文数のうち、最大のものは 9009 = 91 × 99 である。
# では、3桁の数の積で表される回文数のうち最大のものはいくらになるか。

# 2桁
n = (1..9).to_a # => [1, 2, 3, 4, 5, 6, 7, 8, 9]
# 2桁の数字を生成
ary = n.product([0, *n]).map {|a, b| ("#{a}" + "#{b}").to_i}
# 2桁 x 2桁のすべての組み合わせの積を大きい順に並べた中から回文数であるものを選択
palindromic_ary = ary.product(ary).map {|a, b| a * b}.uniq.sort.reverse.select do |n|
  num_ary = n.to_s.split(//)
  0.step((num_ary.length / 2).to_i).to_a.all? {|i| num_ary[i] == num_ary[-1 - i]}
end
p palindromic_ary.max # => 9009

# 3桁
n = (1..9).to_a
ary = n.product([0, *n], [0, *n]).map {|a, b, c| ("#{a}" + "#{b}" + "#{c}").to_i}
palindromic_ary = ary.product(ary).map {|a, b| a * b}.uniq.sort.reverse.select do |n|
  num_ary = n.to_s.split(//)
  0.step((num_ary.length / 2).to_i).to_a.all? {|i| num_ary[i] == num_ary[-1 - i]}
end
p palindromic_ary.max # => 906609

