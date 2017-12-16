#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

programs = ("a".."p").to_a
dance_moves = input.strip.split(",")

dance_moves.each do |dance_move|
  char_stream = dance_move.chars

  move = char_stream.shift
  case move
  when "s"
    programs.rotate!(-char_stream.join.to_i)
  when "x"
    indices = char_stream.join.split("/").map(&:to_i)

    tmp = programs[indices[0]]
    programs[indices[0]] = programs[indices[1]]
    programs[indices[1]] = tmp
  when "p"
    dancing_programs = char_stream.join.split("/")
    indices = dancing_programs.map { |p| programs.index(p) }

    tmp = programs[indices[0]]
    programs[indices[0]] = programs[indices[1]]
    programs[indices[1]] = tmp
  end
end

puts programs.join
