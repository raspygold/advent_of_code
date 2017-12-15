#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

score = 0
depth = 0

collecting_garbage = false
char_stream = input.strip.split("").each
loop do
  begin # catching StopIteration
    char = char_stream.next

    case char
    when "!"
      char_stream.next
    when "<"
      collecting_garbage = true
    when ">"
      collecting_garbage = false
    when "{"
      unless collecting_garbage
        depth += 1
        score += depth
      end
    when "}"
      depth -= 1 unless collecting_garbage
    end
  end
end

p score
