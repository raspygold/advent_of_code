#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

registers = Hash.new(0)

def resolve(registers, register_or_value)
  if (value = register_or_value.to_i).to_s == register_or_value # int
    value
  else # register
    registers[register_or_value]
  end
end

commands = input.map(&:strip)
idx = 0
mul_count = 0
loop do
  command_str = commands[idx]
  pieces = command_str.split(" ")
  command, x, y = pieces

  case command
  when "set" # set register
    registers[x] = resolve(registers, y)
  when "sub" # subtract from register
    registers[x] -= resolve(registers, y)
  when "mul" # multiply register
    mul_count += 1
    registers[x] *= resolve(registers, y)
  when "jnz" # jump instructions
    idx += resolve(registers, y) - 1 if resolve(registers, x) != 0
  end

  idx += 1
  break unless idx >= 0 && idx < commands.size
end


puts mul_count
