#!/usr/bin/env ruby
file_path = File.expand_path("../input2", __FILE__)
input     = File.readlines(file_path)

class Sculpture
  class Disc < Struct.new(:positions, :starts_at); end

  def initialize(input)
    @discs = input.map do |line|
      positions, starts_at = /(\d+) positions; at time=\d+, it is at position (\d+)/.match(line).captures.map(&:to_i)

      Disc.new(positions, starts_at)
    end
  end

  def open_after?(seconds)
    @discs.each.with_index do |disc, i|
      current_position = (disc.starts_at + seconds + i + 1) % disc.positions
      return false unless current_position == 0
    end
    return true
  end

  def simulate
    i = 1
    loop do
      return i if open_after?(i)
      i += 1
    end
  end
end

sculpture = Sculpture.new(input)

puts "", "The first time you can press the button to get a capsule is: #{sculpture.simulate}"
