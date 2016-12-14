#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path).strip.freeze

require "digest"

otp_keys = {}
threepete_indices = Hash.new { |h, k| h[k] = [] }

i = 0
loop do
  hash = Digest::MD5.hexdigest("#{input}#{i}")
  2016.times do
    hash = Digest::MD5.hexdigest(hash)
  end

  fivepete_match = /(\w)#{"\\1"*4}/.match(hash)
  if fivepete_match
    repeating_char = fivepete_match.captures.first
    threepete_indices[repeating_char].each do |c|
      if c.between?(i - 1000, i)
        otp_keys[c] = hash
        print "."

        if otp_keys.length >= 64
          puts "", "The index that produces the 64th OTP key is: #{otp_keys.keys.last}"
          exit
        end
      end
    end
  end


  threepete_match = /(\w)#{"\\1"*2}/.match(hash)
  if threepete_match
    repeating_char = threepete_match.captures.first
    threepete_indices[repeating_char] << i
  end

  i += 1
end
