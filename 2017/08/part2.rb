#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

registers = Hash.new(0)
high_val = 0
input.map do |line|
  pieces = line.strip.split(" ")
  reg, op, val, _, cond_reg, *cond = pieces

  if eval("registers['#{cond_reg}'] && registers['#{cond_reg}']#{cond.join}")
    eval("registers[reg] #{op=='inc' ? '+' : '-'}= val.to_i")
    high_val = registers[reg] if registers[reg] > high_val
  end
end

p high_val
