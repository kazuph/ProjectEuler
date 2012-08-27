#!/usr/bin/env perl
# 10未満の自然数のうち、3 もしくは 5 の倍数になっているものは 3,  5,  6,  9 の4つがあり、 これらの合計は 23 になる。
# 同じようにして、1, 000 未満の 3 か 5 の倍数になっている数字の合計を求めよ。
use Time::HiRes qw/gettimeofday tv_interval/;
use Inline C;
my $start = [gettimeofday];
print sum(1000, 3, 5), "\n";
my $end = [gettimeofday];
printf "time = %.3f", tv_interval($start, $end);
__END__
__C__
double sum(int max, int num1, int num2) {
    double sum = 0;
    int i = 0;
    for(i = 1 ; i < max ; i++) {
        if (i % num1 == 0 || i % num2 == 0) {
            sum += i;
        }
    }
    return sum;
}
