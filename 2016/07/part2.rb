#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

def find_abas_or_babs(segment)
  matches = []
  segment.split("").each_cons(3) do |potential_aba|
    matches << potential_aba if potential_aba.uniq.length == 2 && potential_aba[0] == potential_aba[2]
  end

  matches
end

ips_supporting_ssl = 0

input.each do |ip|
  hypernet_segments = ip.scan(/\[(\w+)\]/).flatten
  supernet_segments = ip.strip.split(/\[\w+\]/)

  abas = supernet_segments.flat_map do |segment|
    find_abas_or_babs(segment)
  end
  babs = hypernet_segments.flat_map do |segment|
    find_abas_or_babs(segment)
  end
  next if abas.empty? || babs.empty?

  if abas.any? { |aba| babs.include?([aba[1],aba[0],aba[1]]) }
    ips_supporting_ssl += 1
    print "."
  end
end

puts "", "The number of IPs found supporting SSL is : #{ips_supporting_ssl}"
