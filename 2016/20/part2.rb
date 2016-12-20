#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

integer_ip_ranges = input.map { |integer_ip_range| /(\d+)-(\d+)/.match(integer_ip_range).captures.map(&:to_i) }.sort!

blocked_ranges = []
integer_ip_ranges.each do |range_start, range_end|
  overlapping_ranges = blocked_ranges.select do |br|
    br.include?(range_start) || br.include?(range_end) || br.first-1 == range_end || br.last+1 == range_start
  end
  overlapping_ranges.each { |br| blocked_ranges.delete(br)}
  new_range_start = [range_start].tap { |r| r << overlapping_ranges.min_by(&:first).first if overlapping_ranges.any? }.min
  new_range_end   = [range_end].tap { |r| r << overlapping_ranges.min_by(&:last).last if overlapping_ranges.any? }.max

  blocked_ranges << (new_range_start..new_range_end)
end

allowed_ip_count = 0
blocked_ranges.each_cons(2) do |a,b|
  allowed_ip_count += b.first - a.last - 1
end

puts "", "The number of IPs are allowed by the blacklist is: #{allowed_ip_count}"
