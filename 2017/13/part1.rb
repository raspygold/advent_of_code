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

total_severity = 0
firewall_layers.each.with_index do |depth, i|
  total_severity += i * depth if i % (depth * 2 - 2) == 0
end

p total_severity
