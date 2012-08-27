t=1 # triangle number
a=1
cnt=0
while cnt < 500
  cnt = 0
  a = a + 1
  t = t + a
  ttx = Math.sqrt(t)
  # for (int i=1; i < ttx; i++){
  (1..ttx).each do |i|
    cnt=cnt+2 if t % i == 0
  end
end

cnt-= 1 if t==ttx*ttx
print t
