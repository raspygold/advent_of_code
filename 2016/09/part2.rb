#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

input_buffer = input.strip.split("")

class CompressedBlock

  attr_accessor :marker, :compressed_input

  def initialize(input_buffer)
    @input_buffer = input_buffer
    @sub_block = []

    read_marker
    read_compressed_input
  end

  def self.build(input_buffer)
    block = CompressedBlock.new(input_buffer)
    block.decompressed_input
  end

  def read_marker
    @marker = []
    loop do
      char = @input_buffer.shift
      next if char =~ /[\s\n]/

      char == ")" ? break : @marker << char
    end

    @compressed_length, @compressed_multiplier = /(\d+)x(\d+)/.match(@marker.join).captures.map(&:to_i)
  end

  def read_compressed_input
    @compressed_input = []
    loop do
      break if @compressed_input.length >= @compressed_length

      char = @input_buffer.shift
      next if char =~ /[\s\n]/
      @compressed_input << char
    end

    if @compressed_input.include?("(") # Indicates there's a nested compressed block somewhere inside, assumed no stray ( chars exist in the input
      nested_blocks = []
      loop do
        nested_blocks << CompressedBlock.build(@compressed_input)
        break if @compressed_input.empty?
      end
      @compressed_input = nested_blocks.join
    end
  end

  def decompressed_input
    @compressed_input * @compressed_multiplier
  end

end

blocks = []
loop do
  blocks << CompressedBlock.build(input_buffer)
  print "."
  break if input_buffer.empty?
end
puts

decompressed_length = blocks.map(&:size).reduce(&:+)

puts "", "the decompressed length of the file is: #{decompressed_length}"
