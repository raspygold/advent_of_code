#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

scramble = "abcdefgh".split("")

input.each do |operation|
  case operation
  when /swap position (\d+) with position (\d+)/
    a, b = [$1, $2].map(&:to_i)
    scramble = scramble.map.with_index do |c, i|
      i == a ? scramble[b] : (i == b ? scramble[a] : c)
    end

  when /swap letter ([a-z]) with letter ([a-z])/
    scramble = scramble.map do |c|
      c == $1 ? $2 : (c == $2 ? $1 : c)
    end

  when /rotate (left|right) (\d+) step/
    direction_modifier = $1 == "left" ? 1 : -1
    scramble.rotate!($2.to_i * direction_modifier)

  when /rotate based on position of letter ([a-z])/
    i = scramble.index($1)
    scramble.rotate!(-(1 + i + (i >= 4 ? 1 : 0)))

  when /reverse positions (\d+) through (\d+)/
    a, b = [$1, $2].map(&:to_i)
    scramble = scramble[0...a] + scramble[a..b].reverse + scramble[(b+1)...scramble.length]

  when /move position (\d+) to position (\d+)/
    a, b = [$1, $2].map(&:to_i)
    c = scramble.delete_at(a)
    scramble.insert(b, c)
  end

end

puts "", "The result of scrambling 'abcdefgh' is: #{scramble.join}"
