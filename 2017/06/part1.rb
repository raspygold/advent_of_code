#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

memory_banks = input.strip.split(" ").map(&:to_i)
seen_states = {}
cycle_count = 0

loop do
  block_to_redirestribute = memory_banks.index(memory_banks.max)

  (memory_banks[block_to_redirestribute]).times do |i|
    redistribution_block = (block_to_redirestribute + i + 1) % memory_banks.length
    memory_banks[redistribution_block] += 1
    memory_banks[block_to_redirestribute] -= 1
  end
  cycle_count += 1

  if seen_states[memory_banks]
    puts "cycle size: #{cycle_count - seen_states[memory_banks]}"
    break
  end

  seen_states[memory_banks] = cycle_count
end

