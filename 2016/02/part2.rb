#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

keypad = [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]

x = nil
keypad = [[x,  x,   1,   x,  x],
          [x,  2,   3,   4,  x],
          [5,  6,   7,   8,  9],
          [x, "A", "B", "C", x],
          [x,  x,  "D",  x,  x]]
current_button = [2, 0]

code   = []

movements = {
  "U" => [-1,  0],
  "D" => [ 1,  0],
  "R" => [ 0,  1],
  "L" => [ 0, -1]
}

input.each.with_index do |line, index|
  line.strip.split("").each do |movement|
    next_button = [
      current_button[0] + movements[movement][0],
      current_button[1] + movements[movement][1]
    ]
    current_button = next_button if next_button.all? { |i| (0..keypad.length-1).include?(i) } && keypad[next_button[0]] && keypad[next_button[0]][next_button[1]]
  end

  code << keypad[current_button[0]][current_button[1]]
end


puts "The bathroom code is #{code.join}"
