#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
$input     = File.read(file_path).strip.freeze

require "digest"

def confirmed_key?(char:, from:)
  i = 1
  loop do
    hash = Digest::MD5.hexdigest("#{$input}#{from + i}").downcase
    return true if hash =~ /(#{char})#{"\\1"*(4)}/

    i += 1
    break if i > 1000
  end
end

keys = []

i = 0
loop do
  hash = Digest::MD5.hexdigest("#{$input}#{i}").downcase
  match = /(\w)\1\1/.match(hash)

  if match
    repeating_char = match.captures.first
    if confirmed_key?(char: repeating_char, from: i)
      keys << hash
      print "."
    end
  end

  break if keys.length >= 64
  i += 1
end


puts "", "The index that produces the 64th OTP key is: #{i}"
