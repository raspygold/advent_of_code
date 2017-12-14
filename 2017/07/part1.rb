#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

program_weights = Hash[input.map do |line|
  name, weight = /(\w+) \((\d+)\)/.match(line.strip).captures
  [name, weight.to_i]
end]

non_base_programs = []
input.map do |line|
  pieces = line.strip.split(" ")
  if pieces.length > 2
    non_base_programs += pieces[3..-1].map { |piece| piece.chomp(",") }
  end
end

p program_weights.keys - non_base_programs
