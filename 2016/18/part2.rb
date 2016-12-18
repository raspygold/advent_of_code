#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).strip

max_rows  = 400000
trap_tile = "^"
safe_tile = "."

tiles = [input.split("")] # First row only

loop do
  last_row = tiles.last

  new_row = ([nil] * last_row.size).map.with_index do |c, i|
    last_row_left   = last_row[i - 1] if (i - 1) >= 0
    last_row_right  = last_row[i + 1] if (i + 1) < last_row.size

    if [last_row_left, last_row_right].one? { |c| c == trap_tile }
      trap_tile
    else
      safe_tile
    end
  end

  tiles << new_row
  break if tiles.size >= max_rows
end

safe_tile_count = tiles.flatten.select { |c| c == safe_tile }.size

puts "", "The number of safe tiles is: #{safe_tile_count}"
