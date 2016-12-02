#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

require "json"


# input_json = JSON.parse input

total = 0
input.scan(/-?\d+/) do |num|
  total += num.to_i
  puts num.to_i if num.to_i < 0
end


puts total
# => 191164
