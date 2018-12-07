#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  step_dependancies = input.inject(Hash.new {|hsh, key| hsh[key] = []}) do |hsh, step|
    step, depends_on = step.match(/Step (.+) must be finished before step (.+) can begin\./)[1..-1].reverse
    hsh[step] << depends_on
    hsh
  end
  all_steps       = (step_dependancies.keys + step_dependancies.values.flatten)
  (step_dependancies.values.flatten - step_dependancies.keys).uniq.each { |step| step_dependancies[step] = [] }
  steps_in_order  = []
  26.times do
    possible_steps = step_dependancies.reject {|k,v| steps_in_order.include?(k)}
                                      .select {|k, v| v.all? {|s| steps_in_order.include?(s)} }.keys
    steps_in_order << possible_steps.sort.first # works if one or many options
    break if (all_steps - steps_in_order).empty?
  end
  steps_in_order.join
end
## SOLUTION ENDS

# test scenarios
test(["Step C must be finished before step A can begin.",
"Step C must be finished before step F can begin.",
"Step A must be finished before step B can begin.",
"Step A must be finished before step D can begin.",
"Step B must be finished before step E can begin.",
"Step D must be finished before step E can begin.",
"Step F must be finished before step E can begin."], "CABDFE")

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
