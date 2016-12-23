#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

registers = Hash.new { |h, k| h[k] = 0 }
registers["a"] = 7

instruction_index = 0
instructions = input


def is_register?(s)
  s.to_i.to_s != s # is not a number
end

def modify_instruction(instructions, instruction_index)
  instruction_modifications = {
    "inc" => "dec",
    "dec" => "inc",
    "tgl" => "inc",
    "cpy" => "jnz",
    "jnz" => "cpy",
  }
  cmd = instructions[instruction_index].split(" ").first
  instructions[instruction_index] = instructions[instruction_index].sub(/#{cmd}/, instruction_modifications[cmd])
end

loop do
  instruction = instructions[instruction_index]

  case instruction.split(" ").first
  when "cpy"
    v, r = /cpy ([-\w]+) ([abcd])/.match(instruction).captures
    registers[r] = is_register?(v) ? registers[v] : v.to_i
  when "inc"
    r = /inc ([abcd])/.match(instruction).captures.first
    registers[r] += 1
  when "dec"
    r = /dec ([abcd])/.match(instruction).captures.first
    registers[r] -= 1
  when "jnz"
    match = /jnz ([abcd\d]) ([-\w]+)/.match(instruction)
    if match
      r, j = match.captures
      if (is_register?(r) ? registers[r] : r.to_i) != 0
        instruction_index += is_register?(j) ? registers[j] : j.to_i
        next
      end
    end
  when "tgl"
    r = /tgl ([abcd\d])/.match(instruction).captures.first
    j =  (is_register?(r) ? registers[r] : r.to_i)
    target = instruction_index + j

    modify_instruction(instructions, instruction_index + j) unless target >= instructions.length
  end

  instruction_index += 1
  break if instruction_index >= instructions.size
end

puts "", "Value left in register a is: #{registers["a"]}"
