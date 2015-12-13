#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

require 'set'

nice_strings = Set.new

def nice?(str)
  pairs = {}
  str.strip.chars.each_cons(2).with_index do |cons, index|
    pairs[cons] ||= []
    pairs[cons] << index
  end

  duplicate_pairs = pairs.map do |key, indices|
    next unless indices.size > 1

    (indices[-1] - indices[0]) > 1
  end.any?
  letter_sandwich = str.chars.each_cons(3).to_a
      .select { |cons| cons[0] == cons[2] }.any?

  duplicate_pairs && letter_sandwich
end

# A bit yucky
input.each do |str|
  nice_strings << str if nice?(str)
end

puts nice_strings.size
# => 55
