#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  entries = input.map do |entry| 
    e = entry.match(/(\d+)-(\d+) (\d+):(\d+)\] (.+)/)[1..-1]
    e[0...-1].map(&:to_i) << e[-1]
  end
  entries.sort!

  guards = Hash.new() {|h,k| h[k]=[]}

  loop do 
    e = entries.shift
    id    = e[-1].match(/Guard #(\d+)/)[1].to_i
    mins = [nil]*60

    loop do
      if entries.empty? || entries.first[-1].match(/Guard #(\d+)/)
        guards[id] << mins
        break 
      end

      e = entries.shift
      (e[3]..59).each do |i| 
        mins[i] = e[-1].match(/falls asleep/) ? i : nil
      end
    end
    break if entries.empty?
  end

  guards.values.each {|v| v.map(&:compact!)}
  sleepy_guard = guards.max_by do |gid, mins|
    mins.map(&:size).reduce(&:+)
  end

  freq = (0..59).inject({}) do |hsh, min|
    hsh[min] = sleepy_guard[1].count {|sleeps| sleeps.include?(min)}
    hsh
  end
  most_common_min = freq.max_by {|x| x[1]}[0]
  
  most_common_min * sleepy_guard[0]
end
## SOLUTION ENDS

# test scenarios
test([
  "[1518-11-01 00:00] Guard #10 begins shift",
  "[1518-11-01 00:05] falls asleep",
  "[1518-11-01 00:25] wakes up",
  "[1518-11-01 00:30] falls asleep",
  "[1518-11-01 00:55] wakes up",
  "[1518-11-01 23:58] Guard #99 begins shift",
  "[1518-11-02 00:40] falls asleep",
  "[1518-11-02 00:50] wakes up",
  "[1518-11-03 00:05] Guard #10 begins shift",
  "[1518-11-03 00:24] falls asleep",
  "[1518-11-03 00:29] wakes up",
  "[1518-11-04 00:02] Guard #99 begins shift",
  "[1518-11-04 00:36] falls asleep",
  "[1518-11-04 00:46] wakes up",
  "[1518-11-05 00:03] Guard #99 begins shift",
  "[1518-11-05 00:45] falls asleep",
  "[1518-11-05 00:55] wakes up",
], 240)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
