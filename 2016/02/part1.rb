#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

keypad = [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]
current_button = [1, 1]

code   = []

movements = {
  "U" => [-1,  0],
  "D" => [ 1,  0],
  "R" => [ 0,  1],
  "L" => [ 0, -1]
}

input.each do |line|
  line.strip.split("").each do |movement|
    next_button = [
      current_button[0] + movements[movement][0],
      current_button[1] + movements[movement][1]
    ]
    current_button = next_button unless next_button.any? { |i| i > 2 || i < 0 }
  end

  code << keypad[current_button[0]][current_button[1]]
end


puts "The bathroom code is #{code.join}"
