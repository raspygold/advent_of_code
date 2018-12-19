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
  possible_opscodes  = Hash.new {|hsh, k| hsh[k] = []}
  confirmed_opscodes = {}

  # Determine opscode numbers
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
    possible_opscodes[instr[0]] << poss_opscodes.keys
  end

  possible_opscodes.each { |k,v| possible_opscodes[k] = v.reduce(&:&) }

  loop do 
    break if possible_opscodes.empty? # identified every opscode

    possible_opscodes.select { |k, v| v.size == 1 }.each do |k, v|
      confirmed_opscodes[k] = opscodes[v.first]
      possible_opscodes.delete(k)
      possible_opscodes.values.each do |pops|
        pops.delete(v.first)
      end
    end
  end

  # Run program
  registers = Array.new(4){0}
  input.shift # soak up extra line
  input.shift # soak up extra line

  loop do 
    break if input.empty?
    instr  = input.shift.match(/(\d+) (\d+) (\d+) (\d+)/)[1..-1].map(&:to_i)
    confirmed_opscodes[instr[0]].call(*instr[1..-1], registers)
  end

  registers[0]
end
## SOLUTION ENDS

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input", false))
