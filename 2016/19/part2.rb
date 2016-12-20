#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).strip

elves_playing = (1..input.to_i).to_a

loop do
  elf_eliminated = elves_playing.size == 2 ? 1 : (elves_playing.size/2)
  elves_playing.delete_at(elf_eliminated)

  break if elves_playing.one?
  elves_playing.rotate!
end


puts "", "The Elf who gets all the presents is: #{elves_playing.first}"
