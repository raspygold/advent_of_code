#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

digits = input.strip.split("").map(&:to_i)

sum = 0
digits.each.with_index do |digit, i|
  halfway_index = (i + (digits.length/2)) % digits.length
  sum += digit if digit == digits[halfway_index]
end

puts sum
