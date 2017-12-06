#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

instructions = input.map { |line| line.strip.to_i }

next_step = steps_taken = 0

loop do
  next_instruction = instructions[next_step]
  next_instruction > 2 ? instructions[next_step] -= 1 : instructions[next_step] += 1

  next_step += next_instruction
  steps_taken += 1

  break if next_step < 0 || next_step >= instructions.length
end

puts "Steps to exit: #{steps_taken}"
