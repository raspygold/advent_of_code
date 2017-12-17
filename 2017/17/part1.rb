#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).to_i

buffer = [0]
idx = 0
(1..2017).each do |i|
  idx = (idx + input) % i + 1
  buffer.insert(idx, i)
end

puts idx+1, buffer[idx+1]
