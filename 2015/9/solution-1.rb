#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

distances = Hash.new { |hash, key| hash[key] = {} }

input.each do |distance|
  places = /\A(\w+)\Wto\W(\w+)\W=\W(\d+)/.match(distance.strip)
  from, to, distance = [places[1], places[2], places[3]]

  distances[from][to] = distances[to][from] = distance.to_i
end

routes = distances.keys.permutation.map do |route|
  route.each_cons(2).to_a.map do |from, to|
    distances[from][to]
  end.reduce(:+)
end

p routes.min
# => 117
