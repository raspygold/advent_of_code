#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

registers = Hash.new(0)
input.map do |line|
  pieces = line.strip.split(" ")
  reg, op, val, _, cond_reg, *cond = pieces

  eval("registers[reg] #{op=='inc' ? '+' : '-'}= val.to_i") if eval("registers['#{cond_reg}'] && registers['#{cond_reg}']#{cond.join}")
end

p registers.values.max
