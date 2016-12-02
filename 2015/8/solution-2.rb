#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

class SantasList

  def initialize(input)
    @input = input
    @list = []

    load_list
  end

  def load_list
    @input.each do |list_item|
      @list << ListItem.new(list_item.strip)
    end
  end

  def size_in_code
    @list.map { |item| item.size_in_code }.reduce(:+)
  end

  def size_when_encoded
    @list.map { |item| item.size_when_encoded }.reduce(:+)
  end

  class ListItem < Struct.new(:string)

    def size_in_code
      string.length
    end

    def size_when_encoded
      string.inspect.length
    end

  end

end


santas_list = SantasList.new(input)

p santas_list.size_when_encoded - santas_list.size_in_code
# => 1333
