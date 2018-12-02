#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  states         = Hash.new {|hsh, k| hsh[k] = {}}

  init_state     = input.shift.match(/state (.)/)[1].freeze
  checksum_after = input.shift.match(/(\d+) steps/)[1].to_i.freeze

  # build states
  loop do
    instr        = input.shift # empty line
    name         = input.shift.match(/state (.)/)[1]
    states[name] = Hash.new {|hsh, k| hsh[k] = {}}
    for_value    = input.shift.match(/value is (\d)/)[1].to_i
    states[name][for_value] = {
      "write"     => input.shift.match(/the value (\d)/)[1].to_i,
      "move"      => input.shift.match(/(right|left)/)[1],
      "new_state" => input.shift.match(/ state (.)/)[1],
    }
    for_value    = input.shift.match(/value is (\d)/)[1].to_i
    states[name][for_value] = {
      "write"     => input.shift.match(/the value (\d)/)[1].to_i,
      "move"      => input.shift.match(/(right|left)/)[1],
      "new_state" => input.shift.match(/ state (.)/)[1],
    }

    break if input.empty?
  end
  states.freeze

  # follow instructions and write to tape
  tape       = [0]
  curr_state = init_state
  curr_index = 0
  checksum_after.times do |i|
    instrs = states[curr_state][tape[curr_index]]
    tape[curr_index] = instrs["write"]
    if instrs["move"] == "right"
      curr_index += 1
      tape[curr_index] ||= 0
    else
      if curr_index == 0 # prepent insteadd of moving
        tape.unshift(0) 
      else
        curr_index -= 1
      end
    end
    curr_state =  instrs["new_state"]
    print "." if i % 10000 == 0
  end
  puts


  checksum = tape.reduce(&:+) || 0
  # checksum
  checksum
end
## SOLUTION ENDS

# test scenarios
test_input = %Q(Begin in state A.
Perform a diagnostic checksum after 6 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.).split("\n")
test(test_input, 3)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
