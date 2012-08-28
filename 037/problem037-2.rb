#!/usr/bin/env ruby
# encoding : utf-8
require 'set'
t = Time.now
def primes n
  p = Array.new(n){|i| i}
  (2..(Math.sqrt(n).ceil)).each do |i|
    next if !p[i]
    (2..(n/i)).each do |j|
      p[i*j] = false
    end
  end
  p.select{|n| n}[2..-1]
end

def truncatable? n
  n.size > 1 &&
  (1...n.size).all? do |i|
    @p.include?(n[i..-1].to_i) &&
    @p.include?(n[0..(-1-i)].to_i)
  end
end

@p = Set.new(primes(1_000_000))

puts @p.select{|n| truncatable? n.to_s}.inject{|s,i| s+i}
puts "実行時間：%.0f msec" %  ((Time.now - t)*1000).to_i
