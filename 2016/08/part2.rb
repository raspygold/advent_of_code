#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

screen = (0...50).map { [0] * 6 }

def rect(screen, args)
  x, y = /(\d+)x(\d+)/.match(args.first).captures.map(&:to_i)
  screen[0...x].each { |row| (0...y).each { |i| row[i]; row[i] = 1 } }
  screen
end

def rotate(screen, args)
  target = args[0]
  index  = /[xy]=(\d+)/.match(args[1]).captures.first.to_i
  steps  = args[3].to_i

  screen = screen.transpose if target == "row"
  screen = screen.map.with_index { |column, i| i == index ? column.rotate(-steps) : column }
  screen = screen.transpose if target == "row"

  screen
end

input.each do |line|
  command, *args = line.strip.split(" ")

  case command
  when "rect"
    screen = rect(screen, args)
  when "rotate"
    screen = rotate(screen, args)
  end

  print "."
end

puts ""
screen.transpose.each do |row|
  row.each do |pixel|
    print pixel == 1 ? "▓" : " "
  end
  puts
end

=begin
▓▓▓▓ ▓▓▓▓ ▓  ▓ ▓▓▓▓  ▓▓▓ ▓▓▓▓  ▓▓   ▓▓  ▓▓▓   ▓▓
   ▓ ▓    ▓  ▓ ▓    ▓    ▓    ▓  ▓ ▓  ▓ ▓  ▓ ▓  ▓
  ▓  ▓▓▓  ▓▓▓▓ ▓▓▓  ▓    ▓▓▓  ▓  ▓ ▓    ▓  ▓ ▓  ▓
 ▓   ▓    ▓  ▓ ▓     ▓▓  ▓    ▓  ▓ ▓ ▓▓ ▓▓▓  ▓  ▓
▓    ▓    ▓  ▓ ▓       ▓ ▓    ▓  ▓ ▓  ▓ ▓    ▓  ▓
▓▓▓▓ ▓    ▓  ▓ ▓    ▓▓▓  ▓     ▓▓   ▓▓▓ ▓     ▓▓
=end
