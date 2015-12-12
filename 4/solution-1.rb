#!/usr/bin/env ruby
input     = "ckczppom"

require "digest"

num = -1

loop do
  num += 1
  hash = Digest::MD5.hexdigest("#{input}#{num}")

  break if hash[0...5] == "0"*5
end

puts num
# => 117946
