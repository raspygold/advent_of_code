#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

sector_id_total = 0

input.each do |room|
  *room_name_pieces, sector_id = room.split("[").first.split("-")
  room_name_pieces = room_name_pieces.join
  checksum  = /\[\w+\]/.match(room)[0][1...-1]

  character_counts = room_name_pieces.split("").each.with_object(Hash.new(0)) { |c, hsh| hsh[c] += 1 }.sort_by { |k,v| [-v, k] }

  calculated_check_sum = character_counts.take(5).map(&:first).join

  sector_id_total += sector_id.to_i if checksum == calculated_check_sum
end


puts "The sum of the sector IDs of the real rooms is #{sector_id_total}"
