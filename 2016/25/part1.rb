#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

instructions = input

def is_register?(s)
  s.to_i.to_s != s # is not a number
end

transmission = []
i = 0
loop do
  registers = Hash.new { |h, k| h[k] = 0 }
  registers["a"] = i
  transmission = []

  instruction_index = 0
  loop do
    instruction = instructions[instruction_index]

    case instruction.split(" ").first
    when "cpy"
      v, r = /cpy (\w+) ([abcd])/.match(instruction).captures
      registers[r] = is_register?(v) ? registers[v] : v.to_i
    when "inc"
      r = /inc ([abcd])/.match(instruction).captures.first
      registers[r] += 1
    when "dec"
      r = /dec ([abcd])/.match(instruction).captures.first
      registers[r] -= 1
    when "jnz"
      r, j = /jnz ([abcd\d]) ([-\d]+)/.match(instruction).captures
      if (is_register?(r) ? registers[r] : r.to_i) != 0
        instruction_index += j.to_i
        next
      end
    when "out"
      r = /out ([abcd])/.match(instruction).captures.first
      break if transmission.last == registers[r]
      transmission << registers[r]
    end

    instruction_index += 1
    break if instruction_index >= instructions.size || transmission.size >= 50
  end

  break if transmission.size >= 50
  i += 1
end

puts "", "What is the lowest positive integer that can be used is: #{i}"
