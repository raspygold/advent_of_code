#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

class AccountingCounter
  require "json"

  attr_accessor :total

  def initialize(input)
    @input = input
    @total = 0
  end

  def count(input = @input)
    if input.is_a? Hash
      return if (input.keys + input.values).include?("red")

      input.each do |e|
        count e
      end
    elsif input.is_a? Array
      input.each do |e|
        count e
      end
    elsif input.is_a? String
      # puts "String!"
    elsif input.is_a? Fixnum
      @total += input
    end
  end

end

input_json = JSON.parse input

counter = AccountingCounter.new(input_json)
counter.count



puts counter.total
# => 87842
