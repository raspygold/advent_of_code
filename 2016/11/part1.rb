#!/usr/bin/env ruby
require 'set'

def valid_state?(state)
  return false if $previous_states.include?(state)

  state[:floors].all? do |floor|
    floor.select { |item| item && item.end_with?("mc")}.all? do |mc|
      generators = floor.select { |item| item && item.end_with?("gn")}
      isotope = mc[0..1]
      generators.any? { |gn| gn.start_with?(isotope) } || generators.none?
    end
  end
end

def final?(state)
  state[:floors][0..2].all? { |floor| floor.empty? } # everything is on floor 4
end

def determine_next_states(state)
  elevator_floor = state[:elevator_floor]
  floor_contents = state[:floors][elevator_floor]

  possible_moves  = (floor_contents.permutation(1).to_a + floor_contents.permutation(2).to_a).map(&:sort).uniq
  possible_floors = [elevator_floor-1, elevator_floor+1].select { |floor| floor.between?(0, 3) }

  next_states = []

  possible_moves.each do |items_to_move|
    possible_floors.each do |next_floor|
      new_state = Marshal.load(Marshal.dump(state)) # deep clone
      items_to_move.each do |item|
        new_state[:floors][next_floor] << new_state[:floors][elevator_floor].delete(item)
      end
      new_state[:floors][next_floor].sort!
      new_state[:elevator_floor] = next_floor

      if valid_state?(new_state)
        next_states << new_state
        $previous_states << new_state
      end
    end
  end

  next_states
end

# initial_state
next_states = [
  elevator_floor: 0,
  floors: [
    ["pr_gn", "pr_mc"],
    ["co_gn", "cu_gn", "pl_gn", "ru_gn" ],
    ["co_mc", "cu_mc", "pl_mc", "ru_mc"],
    []
  ]
]

$start = Time.now.to_f
$previous_states = Set.new
step = 0
loop do
  puts "="*150
  new_states = next_states.flat_map do |state|
    determine_next_states(state)
  end
  step += 1
  print "new_states: #{new_states.length}, step: #{step}, time: #{(Time.now.to_f - $start).round(2)}s", "\n"

  next_states = new_states

  break if next_states.any? { |state| final?(state) }
end

puts "", "Final state is achieve after #{step} moves."
