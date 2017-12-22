#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)


def distance(xyz)
  xyz.map(&:abs).reduce(&:+)
end

class Particle

  attr_reader :id, :p_xyz

  def initialize(id, p_xyz, v_xyz, a_xyz)
    @id    = id
    @p_xyz = p_xyz
    @v_xyz = v_xyz
    @a_xyz = a_xyz
  end

  def tick
    @v_xyz = add_xyz(@v_xyz, @a_xyz)
    @p_xyz = add_xyz(@p_xyz, @v_xyz)
  end

  def add_xyz(a, b)
    [a, b].transpose.map { |arr| arr.reduce(&:+) }
  end
end

particles = []
input.each.with_index do |particle_definition, i|
  pieces = particle_definition.strip.split(", ")
  p_xyz, v_xyz, a_xyz = pieces.map { |piece| /(-?\d+),(-?\d+),(-?\d+)/.match(piece).captures.map(&:to_i) }
  particles << Particle.new(i, p_xyz, v_xyz, a_xyz)
end

last_closest = []

loop do
  1_000.times do
    particles.each(&:tick)
    grouped_particles = particles.group_by(&:p_xyz)
    colliding_particles = grouped_particles.select { |positions, parts| parts.size > 1 }.values.flatten
    particles -= colliding_particles
  end

  sorted_particles = particles.sort do |a,b|
    distance(a.p_xyz) <=> distance(b.p_xyz)
  end
  last_closest << sorted_particles.first.id

  break if last_closest.last(10).size == 10 && last_closest.last(10).uniq.size == 1
end

puts particles.count
