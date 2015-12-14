#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

def parse_coordinates(command)
  min_x, min_y = command.match(/\d+,\d+/)[0].split(",").map(&:to_i)
  max_x, max_y = command.match(/\d+,\d+$/)[0].split(",").map(&:to_i)

  [[min_x, max_x], [min_y, max_y]]
end

lights = Array.new(1000) { Array.new(1000, 0) }

actions = {
  "toggle" => lambda { |state| state + 2 },
  "on"     => lambda { |state| state + 1 },
  "off"    => lambda { |state| [state - 1, 0].max }
}

input.each do |command|
  x_coords, y_coords = parse_coordinates(command)
  actions.each do |action, lambda|
    if command.include? action
      (x_coords.first..x_coords.last).each do |x_coord|
        (y_coords.first..y_coords.last).each do |y_coord|
          lights[x_coord][y_coord] = lambda.call(lights[x_coord][y_coord])
        end
      end

      break
    end
  end
end

p lights.flatten.compact.reduce(:+)
# => 14687245
