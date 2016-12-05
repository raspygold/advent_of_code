#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

real_rooms = []

input.each do |room|
  sector_id = /[[:digit:]]+/.match(room)[0].to_i
  decrypted_room = room.gsub(/[[:alpha:]]/) do |c|
    ("a".ord + ((c.ord - "a".ord) + sector_id % 26) % 26).chr
  end

  room_name_pieces = decrypted_room.split("-")[0..-2]
  checksum  = /\[\w+\]/.match(decrypted_room)[0][1...-1]

  character_counts = room_name_pieces.join.split("").each.with_object(Hash.new(0)) { |c, hsh| hsh[c] += 1 }.sort_by { |k,v| [-v, k] }
  calculated_check_sum = character_counts.take(5).map(&:first).join

  real_rooms << [room_name_pieces.join(" "), sector_id.to_i] if checksum == calculated_check_sum
end

puts real_rooms.inspect
# Answer found by eyeballing room names

