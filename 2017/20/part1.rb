#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

class Particle

  attr_reader :id

  def initialize(id, p_xyz, v_xyz, a_xyz)
    @id    = id
    @p_xyz = p_xyz
    @v_xyz = v_xyz
    @a_xyz = a_xyz
  end

  def acceleration_score
    {
      acceleration_score: @a_xyz.map(&:abs).reduce(&:+),
      velocity_score:     @v_xyz.map(&:abs).reduce(&:+),
      starting_score:     @p_xyz.map(&:abs).reduce(&:+),
    }
  end
end

particles = []
input.each.with_index do |particle_definition, i|
  pieces = particle_definition.strip.split(", ")
  p_xyz, v_xyz, a_xyz = pieces.map { |piece| /(-?\d+),(-?\d+),(-?\d+)/.match(piece).captures.map(&:to_i) }
  particles << Particle.new(i, p_xyz, v_xyz, a_xyz)
end

sorted_particles = particles.sort do |a,b|
  if a.acceleration_score[:acceleration_score] == b.acceleration_score[:acceleration_score]
    if a.acceleration_score[:velocity_score] == b.acceleration_score[:velocity_score]
      a.acceleration_score[:starting_score] <=> b.acceleration_score[:starting_score]
    else
      a.acceleration_score[:velocity_score] <=> b.acceleration_score[:velocity_score]
    end
  else
    a.acceleration_score[:acceleration_score] <=> b.acceleration_score[:acceleration_score]
  end
end

puts sorted_particles.first.id
