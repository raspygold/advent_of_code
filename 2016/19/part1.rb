#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).strip

elves = input.to_i.times.each.with_object({}) { |i, hsh| hsh[i+1] = 1 }

loop do
  remaining_elves = {}
  elves.each_slice(2) do |elf1, elf2|
    elf2 ||= elves.first
    remaining_elves[elf1[0]] = elf1[1] + elf2[1]

    remaining_elves.delete(elf2[0])
  end
  elves = remaining_elves

  break if elves.one?
end

puts "", "The Elf who gets all the presents is: #{elves.first[0]}"
