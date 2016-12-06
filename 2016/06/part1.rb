#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

split_messages = input.map { |message| message.strip.split("") }

corrected_message_chars = split_messages.transpose.map do |message_chars|
  message_chars.group_by { |c| c }.max{ |x,y| x[1].length <=> y[1].length }[0]
end

puts "The error-corrected version of the message being sent is: #{corrected_message_chars.join}"
