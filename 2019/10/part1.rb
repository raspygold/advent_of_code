require_relative "../puzzle"
class Day10P1 < Puzzle
  def test_cases
    { # {input => expected}
      [
        ".#..#",
        ".....",
        "#####",
        "....#",
        "...##",
       ] => { [3,4] => 8 },
      [
        "......#.#.",
        "#..#.#....",
        "..#######.",
        ".#.#.###..",
        ".#..#.....",
        "..#....#.#",
        "#..#....#.",
        ".##.#..###",
        "##...#..#.",
        ".#....####",
      ] => { [5,8] => 33 },
      [
        "#.#...#.#.",
        ".###....#.",
        ".#....#...",
        "##.#.#.#.#",
        "....#.#.#.",
        ".##..###.#",
        "..#...##..",
        "..##....##",
        "......#...",
        ".####.###.",
      ] => { [1,2] => 35 },
      [
        ".#..#..###",
        "####.###.#",
        "....###.#.",
        "..###.##.#",
        "##.##.#.#.",
        "....###..#",
        "..#.#..#.#",
        "#..#.#.###",
        ".##...##.#",
        ".....#.#..",
      ] => { [6,3] => 41 },
      [
        ".#..##.###...#######",
        "##.############..##.",
        ".#.######.########.#",
        ".###.#######.####.#.",
        "#####.##.#.##.###.##",
        "..#####..#.#########",
        "####################",
        "#.####....###.#.#.##",
        "##.#################",
        "#####.##.###..####..",
        "..######..##.#######",
        "####.##.####...##..#",
        ".#####..#.######.###",
        "##...#.##########...",
        "#.##########.#######",
        ".####.#.###.###.#.##",
        "....##.##.###..#####",
        ".#.#.###########.###",
        "#.#.#.#####.####.###",
        "###.##.####.##.#..##",
      ] => { [11,13] => 210 }
    }
  end

  def solve(input, testing: false)
    $max_x = input.first.size - 1
    $max_y = input.size - 1

    # Find all asteroid XY pairs
    asteroid_xys = []
    input.each.with_index do |row, y|
      row.chars.each.with_index do |val, x|
        asteroid_xys << [x, y] if val == '#'
      end
    end

    asteroid_xys_counts = {}
    asteroid_xys.each.with_object(asteroid_xys_counts) do |xy, hsh|
      visible_asteroids = eliminate_blocked_asteroids(xy, asteroid_xys)
      hsh[xy] = visible_asteroids.count
    end

    puts asteroid_xys_counts.inspect
  end

  def eliminate_blocked_asteroids((x,y), all_asteroids)
    other_asteroids = (all_asteroids - [[x,y]])
    other_asteroids.select do |ax, ay|
      dx = ax - x
      dy = ay - y
      puts dx, dy, ""

      # Eliminate straight lines
      if dx == 0
        if dy > 0
          return ((y+1)...ay).none? { |ty| other_asteroids.include?([x, ty]) }
        else
          return ((ay+1)...y).none? { |ty| other_asteroids.include?([x, ty]) }
        end
      elsif
        dy == 0
        if dy > 0
          return ((x+1)...ax).none? { |tx| other_asteroids.include?([tx, y]) }
        else
          return ((ax+1)...x).none? { |tx| other_asteroids.include?([tx, y]) }
        end
      else

        # Eliminate angles
        r_xy = dx.to_f / dy
        r_yx = dy.to_f / dx
        puts r_xy, r_yx, ""

        if r_xy.integer?
          return true if r_xy.odd?
          nx = x
          ny = y
          loop do
            nx += r_xy
            ny += 1
            return false if other_asteroids.include?([nx,ny])
            break if [nx,ny] == [ax,ay] || nx > $max_x || ny > $max_y
          end
        elsif r_yx.integer?
          return true if r_yx.odd?
          nx = x
          ny = y
          loop do
            nx += 1
            ny += r_yx
            return false if other_asteroids.include?([nx,ny])
            break if [nx,ny] == [ax,ay] || nx > $max_x || ny > $max_y
          end
        else
          raise "no ratio between them"
        end

        true
      end
    end
  end
end
