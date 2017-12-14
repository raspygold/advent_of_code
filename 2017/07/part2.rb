#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

# identify all programs
class Program < Struct.new(:name, :weight, :children); end
programs = {}

def calc_weight(programs, name)
  program = programs[name]
  children_weights = program.children.map { |child| [child, calc_weight(programs, child)] }.sort { |x| -x[1] }.to_h

  return program.weight if children_weights.empty?

  if children_weights.values.uniq.size > 1
    grouped_weights = children_weights.group_by { |x| x[1] }.sort { |x| x.size }
    incorrect_weight_child = grouped_weights[0][1][0][0] # yuck
    correct_weight = programs[incorrect_weight_child].weight - grouped_weights.map{|x| x[0]}.uniq.reduce(&:-)
    puts "#{incorrect_weight_child}'s weight should be: #{correct_weight}"

    exit
  end
  total_children_weight = children_weights.values.reduce(&:+)

  return program.weight + total_children_weight
end

input.each do |line|
  pieces = line.strip.split(" -> ")
  name, weight = /(\w+) \((\d+)\)/.match(pieces[0]).captures
  children = pieces[1] ? pieces[1].split(", ") : []

  programs[name] = Program.new(name, weight.to_i, children)
end

all_children = programs.values.map(&:children).flatten
base_program = (programs.keys - all_children).first

calc_weight(programs, base_program)
