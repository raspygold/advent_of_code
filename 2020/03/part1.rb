require_relative "../puzzle"
class Day03P1 < Puzzle
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
      '.#..#...#.#'] => 7
    }
  end

  def solve(input, testing: false)
    movement = [3, 1] # [x, y]
    map = input.map(&:chars)
    repeating_map_width = map.first.size
    tree = '#'
    collisions = 0
    pos = [0, 0]

    loop do
      pos = [(pos[0] + movement[0]) % repeating_map_width, pos[1] + movement[1]]
      break if pos[1] >= map.size

      collisions += 1 if map[pos[1]][pos[0]] == tree
    end

    collisions
  end
end
