#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
# cable is a string, port is a number
def cable_connects_to?(cable, port)
  !!(cable =~ /(^#{port}\/)|(\/#{port}$)/) # reversible cables, so check both ends
end

def compatible_cables(all_cables, bridge, final_port)
  possible_cables = all_cables - bridge
  possible_cables.select do |cable| 
    cable_connects_to?(cable, final_port)
  end
end

def bridge_strength(bridge)
  strength = bridge.reduce(0) do |sum, cable|
    sum + cable.split("/").reduce(0) {|tot, s| tot + s.to_i}
  end
end

def solve(input)
  require "set"
  completed_bridges = Set.new
  bridges_in_progress = Set.new(compatible_cables(input, [], 0).map {|c| [c]}) # the bridges start with cables with an 0 port

  i = 0
  t = Time.now
  loop do 
    newly_completed_bridges = Set.new
    progressed_bridges      = Set.new
    bridges_in_progress.each do |bridge|
      # walk bridge, flipping cables as we go, to find the port at the end

      last_port = 0
      ordered_bridge = bridge.each do |cable|
        last_port = (cable.split("/").map(&:to_i) - [last_port])[0] || last_port # handling single ported cables
      end

      possible_connections = compatible_cables(input, bridge, last_port)
      if possible_connections.any? # still in progress
        possible_connections.each do |cable|
          progressed_bridges << (bridge + [cable])
        end
      else # bridge completed
        newly_completed_bridges << bridge
      end
    end

    completed_bridges += newly_completed_bridges if newly_completed_bridges.any?

    bridges_in_progress = progressed_bridges
    puts "#{i}: #{bridges_in_progress.size} — #{Time.now - t}s [#{newly_completed_bridges.size} newly_completed_bridges]"
    i+=1
    break if progressed_bridges.empty?
  end

  bridges_by_length = completed_bridges.sort_by {|bridge| -bridge.size} # bridges sorted by longest to shortest
  longest_bridge_length = bridges_by_length.first.size
  longest_bridges = bridges_by_length.take_while {|bridge| bridge.size == longest_bridge_length}

  bridges_by_strength = longest_bridges.sort_by {|bridge| -bridge_strength(bridge)} # bridges sorted by strongest to weakest
  puts
  strongest_bridge_strength = bridge_strength(bridges_by_strength.first)

end
## SOLUTION ENDS

# test scenarios
test_input = [
  "0/2",
  "2/2",
  "2/3",
  "3/4",
  "3/5",
  "0/1",
  "10/1",
  "9/10"
]
test(test_input, 19)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
