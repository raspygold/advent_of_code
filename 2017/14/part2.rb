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
  bin_knot_hash = hex_knot_hash.chars.map { |x| x.to_i(16).to_s(2).rjust(4, "0") }.join.chars.map(&:to_i)

  disk << bin_knot_hash
end

require 'matrix'
require 'set'
disk_matrix = Matrix.rows(disk)
# turn the disk into a matrix
# identify used sectors
sectors_to_cluster = Set.new
disk_matrix.each_with_index do |x, row, col|
  sectors_to_cluster << [row, col] if x == 1
end

clusters = Set.new
new_cluster = Set.new
loop do
  break if sectors_to_cluster.empty?

  start_of_cluster = sectors_to_cluster.first
  sectors_to_cluster.delete(start_of_cluster)

  new_cluster = [start_of_cluster]
  clusters << new_cluster # add it to the set of clusters, then fill it up
  loop do
    prev_cluster_size = clusters.size
    new_cluster.each do |sector|
      # look for neighboring sectors to add to the new cluster
      [[1,0], [-1,0], [0,1], [0,-1]].each do |a,b|
        neighbor = [sector[0] + a, sector[1] + b]
        next unless neighbor.all? { |x| x >= 0 } # Make sure it is on the matrix plane

        new_cluster << neighbor if sectors_to_cluster.delete?(neighbor)
      end
    end

    break if prev_cluster_size == clusters.size
  end
end

puts clusters.size
