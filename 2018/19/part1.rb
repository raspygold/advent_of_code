#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  opscodes = {
    # Addition
    addr: -> (a,b,c,registers) { registers[c] = registers[a] + registers[b] },
    addi: -> (a,b,c,registers) { registers[c] = registers[a] + b },
    # Multiplication
    mulr: -> (a,b,c,registers) { registers[c] = registers[a] * registers[b] },
    muli: -> (a,b,c,registers) { registers[c] = registers[a] * b },
    # Bitwise AND
    banr: -> (a,b,c,registers) { registers[c] = registers[a] & registers[b] },
    bani: -> (a,b,c,registers) { registers[c] = registers[a] & b },
    # Bitwise OR
    borr: -> (a,b,c,registers) { registers[c] = registers[a] | registers[b] },
    bori: -> (a,b,c,registers) { registers[c] = registers[a] | b },
    # Assignment
    setr: -> (a,b,c,registers) { registers[c] = registers[a] },
    seti: -> (a,b,c,registers) { registers[c] = a },
    # Greater-than testing
    gtir: -> (a,b,c,registers) { registers[c] = a > registers[b] ? 1 : 0 },
    gtri: -> (a,b,c,registers) { registers[c] = registers[a] > b ? 1 : 0 },
    gtrr: -> (a,b,c,registers) { registers[c] = registers[a] > registers[b] ? 1 : 0 },
    # Equality testing
    eqir: -> (a,b,c,registers) { registers[c] = a == registers[b] ? 1 : 0 },
    eqri: -> (a,b,c,registers) { registers[c] = registers[a] == b ? 1 : 0 },
    eqrr: -> (a,b,c,registers) { registers[c] = registers[a] == registers[b] ? 1 : 0 },
  }

  # Run program
  registers = Array.new(6){0}
  instr_ptr_register = input.shift.match(/\#ip (\d+)/)[1].to_i # soak up extra line

  instructions = input.map do |instr|
    op, *vars = instr.match(/(\w+) (\d+) (\d+) (\d+)/)[1..-1]
    vars.map!(&:to_i)
    [op.to_sym, *vars]
  end
  n=0
  loop do 
    # str = "ip=#{registers[instr_ptr_register]} #{registers.inspect} "
    instr = instructions[registers[instr_ptr_register]]
    # str += instr.inspect
    opscodes[instr[0].to_sym].call(*instr[1..-1], registers)
    # str += " #{registers.inspect}"
    
    break unless (0...instructions.size).include?(registers[instr_ptr_register] + 1)
    registers[instr_ptr_register] += 1 
    n+=1
  end

  registers[0]
end
## SOLUTION ENDS

# test scenarios
test(%Q(
#ip 0
seti 5 0 1
seti 6 0 2
addi 0 1 0
addr 1 2 3
setr 1 0 0
seti 8 0 4
seti 9 0 5
).strip.split("\n"), 6)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input", false))
