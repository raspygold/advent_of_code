require_relative "../puzzle"
class Day03P2 < Puzzle
  def test_cases
    { # {input => expected}
     ['..##.......',
      '#...#...#..',
      '.#....#..#.',
      '..#.#...#.#',
      '.#...##..#.',
      '..#.##.....',
      '.#.#.#....#',
      '.#........#',
      '#.##...#...',
      '#...##....#',
      '.#..#...#.#'] => 336
    }
  end

  def solve(input, testing: false)
    movement_options = [ # [x, y]
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2]
    ]
    map = input.map(&:chars)
    repeating_map_width = map.first.size
    tree = '#'

    movement_options.map do |movement|
      collisions = 0
      pos = [0, 0]

      loop do
        pos = [(pos[0] + movement[0]) % repeating_map_width, pos[1] + movement[1]]
        break if pos[1] >= map.size

        collisions += 1 if map[pos[1]][pos[0]] == tree
      end

      collisions
    end.reduce(&:*)
  end
end
