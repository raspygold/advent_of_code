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

  samples_matching_three_opscodes = 0
  loop do 
    break if input.empty? || !input.first.index("Before")

    before = input.shift.match(/Before: \[(\d+), (\d+), (\d+), (\d+)\]/)[1..-1].map(&:to_i)
    instr  = input.shift.match(/(\d+) (\d+) (\d+) (\d+)/)[1..-1].map(&:to_i)
    after  = input.shift.match(/After:  \[(\d+), (\d+), (\d+), (\d+)\]/)[1..-1].map(&:to_i)
    input.shift # soak up extra line

    poss_opscodes = opscodes.select do |opscode, action|
      registers = before.dup
      action.call(*instr[1..-1], registers)
      registers == after
    end
    samples_matching_three_opscodes+=1 if poss_opscodes.keys.size > 2
  end
  samples_matching_three_opscodes
end
## SOLUTION ENDS

# test scenarios
test(%Q(
Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]
).strip.split("\n"), 1)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input", false))
