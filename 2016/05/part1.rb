#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
door_id   = File.read(file_path).strip

interesting_start = "0" * 5
password = []
inc = 0

require 'digest'
loop do
  digest = Digest::MD5.hexdigest("#{door_id}#{inc}")
  if digest.start_with?(interesting_start)
    password << digest[5]
    print "."
  end

  break if password.length >= 8
  inc += 1
end

puts
puts "The password is #{password.join}"
