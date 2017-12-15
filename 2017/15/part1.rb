#!/usr/bin/env ruby
judge_total = 0

ga_val = 289
gb_val = 629
40_000_000.times do |i|
  ga_val = (ga_val * 16_807) % 2147483647
  gb_val = (gb_val * 48_271) % 2147483647

  judge_total += 1 if ga_val.to_s(2).rjust(16, "0")[-16..-1] == gb_val.to_s(2).rjust(16, "0")[-16..-1]
  print "." if i % 100_000 == 0
end

puts
p judge_total
