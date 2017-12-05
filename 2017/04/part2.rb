#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

valid_passphrases = 0
input.map do |line|
  word_counts = Hash.new(0)
  line.strip.split(" ").each do |word|
    word_counts[word.split("").sort.join] += 1
  end
  valid_passphrases += 1 if word_counts.values.all? { |v| v == 1 }
end

puts "Valid passphrases: #{valid_passphrases}"
