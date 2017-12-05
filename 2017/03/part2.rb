#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

data_location = input.strip.to_i

layers = 1

loop do
  memory_size = layers ** 2
  break if memory_size >= data_location # it's as big a memory storage as we need to draw

  layers += 1
end

layers += 1 if layers.even? # Easier to find the center if the layers are odd

memory = Array.new(layers){ [nil] * layers }
center = (layers / 2).floor

# Fill in the memory grid
y = x = center
memory[y][x] = 1

movements_in_direction = 1
directions = [ [0,+1], [-1,0], [0,-1], [+1,0] ].cycle

i = 0
loop do
  movement_direction = directions.next
  movements_in_direction.times do
    y += movement_direction.first
    x += movement_direction.last

    next_value = [
      memory[y+1][x],
      memory[y-1][x],
      memory[y][x+1],
      memory[y][x-1],
      memory[y-1][x-1],
      memory[y+1][x+1],
      memory[y+1][x-1],
      memory[y-1][x+1]
    ].compact.reduce(&:+)
    memory[y][x] = next_value

    if next_value > data_location
      p next_value
      exit
    end
  end

  break if movements_in_direction >= layers
  i += 1
  movements_in_direction += 1 if i % 2 == 0

end
