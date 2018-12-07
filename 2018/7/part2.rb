#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

WORKERS = 5
DELAY   = Proc.new { |a| 60 + a.ord - 64 }

## SOLUTION BEGINS
def solve(input)
  step_dependancies = input.inject(Hash.new {|hsh, key| hsh[key] = []}) do |hsh, step|
    step, depends_on = step.match(/Step (.+) must be finished before step (.+) can begin\./)[1..-1].reverse
    hsh[step] << depends_on
    hsh
  end
  all_steps       = (step_dependancies.keys + step_dependancies.values.flatten)
  (step_dependancies.values.flatten - step_dependancies.keys).uniq.each { |step| step_dependancies[step] = [] }

  steps_in_order = []
  workers = (0...WORKERS).map.with_index {|w, i| {id: i+1, available_at: 0, working_on: nil }}
  time = 0
  loop do
    workers.each do |w| 
      if w[:available_at] == time && w[:working_on]
        steps_in_order << w[:working_on] 
        w[:working_on] = nil
      end
    end
    workers.select {|w| w[:available_at] <= time}.each do |worker|
      possible_steps = step_dependancies.reject {|k,v| steps_in_order.include?(k)}                  # already done it
                                        .select {|k,v| v.all? {|s| steps_in_order.include?(s)} }    # all pre-reqs completed
                                        .reject {|k,v| workers.any? {|w| w[:working_on] == k} }.keys # already being worked on
      next_step  = possible_steps.sort.first # works if one or many options
      if next_step
        worker[:available_at] = time + DELAY.call(next_step)
        worker[:working_on]   = next_step
      end
    end

    break if (all_steps - steps_in_order).empty?
    time += 1 # tick
  end

  time
end
## SOLUTION ENDS

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
