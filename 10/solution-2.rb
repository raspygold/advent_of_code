#!/usr/bin/env ruby
input = "1321131112"

50.times do
  result = ""
  last_chars = []
  input.chars.each.with_index do |char, i|
    last_chars << char and next if (last_chars.include?(char) || last_chars.empty?)

    result += "#{last_chars.size}#{last_chars.first}"
    last_chars.clear << char
  end

  result += "#{last_chars.size}#{last_chars.first}"

  input = result
end

puts input.length
# => 6989950
