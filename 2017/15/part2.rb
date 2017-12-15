#!/usr/bin/env ruby
judge_total = 0

ga_val = 289
gb_val = 629
5_000_000.times do |i|
  loop do
    ga_val = (ga_val * 16_807) % 2147483647
    break if ga_val % 4 == 0
  end
  loop do
    gb_val = (gb_val * 48_271) % 2147483647
    break if gb_val % 8 == 0
  end

  judge_total += 1 if ga_val.to_s(2).rjust(16, "0")[-16..-1] == gb_val.to_s(2).rjust(16, "0")[-16..-1]
  print "." if i % 10_000 == 0
end

puts
p judge_total
