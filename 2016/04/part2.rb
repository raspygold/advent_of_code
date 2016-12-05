#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

input.each do |room|
  sector_id = /[[:digit:]]+/.match(room)[0].to_i
  decrypted_room = room.gsub(/[[:alpha:]]/) do |c|
    ("a".ord + ((c.ord - "a".ord) + sector_id % 26) % 26).chr
  end

  if decrypted_room.split("-")[0..-2].join(" ").include?("north")
    puts "The sector ID of the room where North Pole objects are stored is #{sector_id}"
    exit
  end
end


