#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

b = input.first.split(" ")[2].to_i * 100 + 100000
c = b + 17000

require "prime"
puts (b..c).step(17).count {|b| !Prime.prime?(b)}

