#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  nodes        = []
  orig_numbers = input.split(" ").map(&:to_i).freeze
  numbers      = orig_numbers.dup
  identify_nodes(numbers, nodes)

  nodes.last[:value]
end

def identify_nodes(numbers, nodes)
  children, metadata = numbers.shift(2)
  node = {
    children: (0...children).map { identify_nodes(numbers, nodes) },
    metadata: [numbers.shift(metadata)].flatten,
  }
  node[:value] = if children.zero? 
    node[:metadata].reduce(&:+)
  else
    node[:metadata].inject(0) do |tot, child_idx|
      unless child_idx.zero?
        child = node[:children][child_idx-1]
        tot  += child[:value] if child
      end
      tot
    end
  end
  nodes << node
  node
end
## SOLUTION ENDS

# test scenarios
test("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2", 66)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
