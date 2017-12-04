#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

digits = input.strip.split("").map(&:to_i)

sum = 0
(digits << digits[0]).each_cons(2) do |a,b|
  sum += a if a == b
end

puts sum
