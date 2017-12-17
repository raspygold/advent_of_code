#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).to_i

idx = 0
n = 0
(1..50_000_000).each do |i|
  idx = (idx + input) % i
  n = i if idx == 0
  idx += 1
end

puts n
