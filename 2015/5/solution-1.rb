#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

require 'set'

nice_strings = Set.new

def nice?(str)
  str.chars.select { |c| %w{ a e i o u }.include?(c) }.size > 2 &&
    str.chars.each_cons(2).to_a.select { |cons| cons[0] == cons[1] }.any? &&
    !(str =~ /ab|cd|pq|xy/)
end

input.each do |str|
  nice_strings << str if nice?(str)
end

puts nice_strings.size
# => 255
