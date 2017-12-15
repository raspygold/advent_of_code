#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

garbage = 0

char_stream = input.strip.chars
collecting_garbage = false
loop do
  char = char_stream.shift

  case char
  when "!"
    char_stream.shift
  when "<"
    collecting_garbage ? garbage += 1 : collecting_garbage = true
  when ">"
    collecting_garbage = false
  else
    garbage += 1 if collecting_garbage
  end

  break if char_stream.empty?
end

p garbage
