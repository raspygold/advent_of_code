#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

require 'set'

def determine_next_moves(current_positions)
  next_positions = Set.new
  current_positions.each do |x, y|
    possible_positions = [-1, 1].map { |n| [x + n, y] } +
                         [-1, 1].map { |n| [x, y + n] }

    possible_positions.each do |new_x, new_y|
      next_positions << [new_x, new_y] if new_x.between?(0, $adj_matrix.first.size) && new_y.between?(0, $adj_matrix.size) && $adj_matrix[y][x] == 1
    end
  end

  next_positions
end

target_cells = {}

$adj_matrix = input.map.with_index do |row, y|
  row.strip.split("").map.with_index do |cell, x|
    case cell
    when "#"
      0
    when "."
      1
    when /(\d)/
      target_cells[$1] = [x,y]
      1
    else
      puts 'bad!'
      exit
    end
  end
end

possible_routes    = target_cells.keys.reject { |k| k == "0" }.permutation.to_a.map { |route| ["0"] + route + ["0"] }
possible_movements = target_cells.keys.permutation(2).to_a.sort
movement_costs     = possible_movements.each.with_object({}) do |(a, b), hsh|
  puts [a, b].inspect
  next_positions = Set.new([target_cells[a]])
  i = 1
  loop do
    next_positions = determine_next_moves(next_positions)

    print "."
    break if next_positions.include?(target_cells[b])
    i += 1
  end
  hsh[[a, b]] = i
  puts ""
end

calculated_possible_routes = possible_routes.map do |possible_route|
  route_cost = []
  possible_route.each_cons(2) do |a, b|
    route_cost << movement_costs[[a, b]]
  end
  route_cost
end

puts "", "Value left in register a is: #{calculated_possible_routes.map { |possible_route| possible_route.reduce(&:+) }.min}"
