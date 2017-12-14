#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

firewall_layers = []
input.each do |layer_desc|
  layer, depth = layer_desc.split(": ").map(&:to_i)
  missing_layers = layer - firewall_layers.size
  missing_layers.times do # some backfilling to do first
    firewall_layers << 0
  end
  firewall_layers << depth
end

# walk the layers
delay = 0
successful_walk = false
loop do
  firewall_layers.each.with_index do |depth, i|

    if depth != 0 && (delay + i) % (depth * 2 - 2) == 0
      delay += 1
      break
    end

    successful_walk = true if i == firewall_layers.size - 1
  end

  break if successful_walk
end

puts "", delay
