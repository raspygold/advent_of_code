#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
door_id   = File.read(file_path).strip

interesting_start = "0" * 5
password          = [nil] * 8
available_indices = (0...password.length).map(&:to_s)
inc = 0

require 'digest'
loop do
  digest = Digest::MD5.hexdigest("#{door_id}#{inc}")
  if digest.start_with?(interesting_start)
    index = digest[5]
    if available_indices.include?(index) && password[index.to_i].nil?
      password[index.to_i] = digest[6]
      print "."
    end
  end

  break if password.all?
  inc += 1
end

puts
puts "The password is #{password.join}"
