#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

class Santa

  def initialize
    @x = @y = 0
  end

  def coords
    [@x, @y]
  end

  def move_north
    @y += 1
  end

  def move_east
    @x += 1
  end

  def move_south
    @y -= 1
  end

  def move_west
    @x -= 1
  end
end

require 'set'

delivered_coords = Set.new

x = y = 0
delivered_coords << [x, y]

santas = [Santa.new, Santa.new]

input.chars.each.with_index do |char, index|
  santa = santas[index % 2]
  case char
  when "^"
    santa.move_north
  when ">"
    santa.move_east
  when "v"
    santa.move_south
  when "<"
    santa.move_west
  end

  delivered_coords << santa.coords
end

puts delivered_coords.count
# => 2360
