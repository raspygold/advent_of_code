#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

def contains_abba?(segment)
  segment.split("").each_cons(4) do |potential_abba|
    return true if potential_abba.uniq.length == 2 && potential_abba[0..1] == potential_abba[2..3].reverse
  end
end

ips_supporting_tls = 0

input.each do |ip|
  in_brackets      = ip.scan(/\[(\w+)\]/).flatten
  outside_brackets = ip.strip.split(/\[\w+\]/)
  if in_brackets.any? { |segment| contains_abba?(segment) }
    next
  elsif outside_brackets.any? { |segment| contains_abba?(segment) }
    ips_supporting_tls += 1
    print "."
  end
end

puts "", "The number of IPs found supporting TLS is : #{ips_supporting_tls}"
