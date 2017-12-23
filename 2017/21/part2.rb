#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

def print_grid(grid)
  puts
  grid.each do |row|
    p row
  end
  puts
end

class EnhancementRule
  attr_reader :to_pattern

  def initialize(definition)
    @from_pattern, @to_pattern = definition.split(" => ").map { |arr| arr.split("/").map(&:chars) }
  end

  def match_pattern?(square)
    return false if square.size != @from_pattern.size

    pattern_permutations.any? { |pattern| pattern == square }
  end

  private

  def pattern_permutations
    patterns = [
      @from_pattern,
      rotate_pattern(@from_pattern, 1),
      rotate_pattern(@from_pattern, 2),
      rotate_pattern(@from_pattern, 3),
    ]
    patterns += patterns.map { |pattern| pattern.reverse }
    patterns += patterns.map { |pattern| pattern.map(&:reverse) }
  end

  def rotate_pattern(grid, rotations)
    rotated_pattern = grid
    rotations.times do
      rotated_pattern = rotated_pattern.transpose.map(&:reverse)
    end

    rotated_pattern
  end
end

enhancement_rules = []
input.each do |definition|
  enhancement_rules << EnhancementRule.new(definition.strip)
end
enhancement_rules.shuffle!

grid = [[".","#","."],
        [".",".","#"],
        ["#","#","#"]]

18.times do |idx|
  puts "#{idx}: #{grid.size * grid.size}"
  sub_grid_size = grid.size % 2 == 0 ? 2 : 3

  groupings = (0...grid.size).each_slice(sub_grid_size).to_a

  small_grids = Array.new(groupings.size) { Array.new(groupings.size) { Array.new(sub_grid_size) { [] } } }
  grid.size.times do |i|
    grid.size.times do |j|
      small_grids[(i/sub_grid_size)][(j/sub_grid_size)][i%sub_grid_size] << grid[i][j]
    end
  end

  new_grids = Array.new(groupings.size) { Array.new(groupings.size) }
  small_grids.size.times do |i|
    small_grids.size.times do |j|
      new_grids[i][j] = enhancement_rules.find { |rule| rule.match_pattern?(small_grids[i][j]) }.to_pattern
    end
  end

  require 'matrix'
  enhanced_grids = new_grids.flatten(2).each_slice(new_grids[0][0].size).to_a
  matrices =  enhanced_grids.map { |grid| Matrix[*grid] }.each_slice(small_grids.size).to_a
  matrix_size = matrices.first.first.row_count
  hstacked_matrices = matrices.map do |horizonal|
    Matrix[*Array.new(matrix_size) { [] }].hstack(*horizonal)
  end
  vstacked_matrices = hstacked_matrices.inject do |matrix, vertical|
    matrix ? matrix.vstack(vertical) : vertical
  end

  grid = vstacked_matrices.to_a
end

active_pixels = grid.inject(0) do |sum, row|
  sum + row.count { |v| v == '#' }
end

puts
puts active_pixels
