#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).strip

disk = []

128.times do |i|
  knot_hash_key = "#{input}-#{i}"

  lengths = knot_hash_key.chars.map(&:bytes).flatten + [17, 31, 73, 47, 23]

  sparse_hash = (0..255).to_a
  skip_position = current_position = 0

  64.times do
    lengths.each do |length|
      rotation = current_position
      sparse_hash.rotate!(rotation) # move the start of the new loop is at the start of the sparse_hash
      sparse_hash = sparse_hash[0...length].reverse + sparse_hash[length..-1]

      current_position = (current_position + length + skip_position) % sparse_hash.size
      sparse_hash.rotate!(-rotation) # move the start of the new loop back to where it was originally

      skip_position += 1
    end
  end

  dense_hash = []
  sparse_hash.each_slice(16) do |block|
    dense_hash << block.reduce(&:^)
  end

  hex_knot_hash = dense_hash.map { |n| n.to_s(16).rjust(2, "0") }.join
  bin_knot_hash = hex_knot_hash.chars.map { |x| x.to_i(16).to_s(2).rjust(4, "0") }.join

  disk << bin_knot_hash
end

p disk.flat_map { |row| row.chars.map(&:to_i).reduce(&:+) }.reduce(&:+)
