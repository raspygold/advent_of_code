require_relative "../puzzle"
class Day05P2 < Puzzle
  def test_cases
    { # {input => expected}
    }
  end

  def solve(input, testing: false)
    boarding_passes = input.map do |boarding_pass|
      row_range = (0..128).to_a
      col_range = (0..7).to_a
      boarding_pass_mods = boarding_pass.chars

      row_data  = boarding_pass_mods[0..6]
      col_data = boarding_pass_mods[7..9]

      row_data.each do |mod|
        if mod == 'F'
          row_range = lower(row_range)
        elsif mod == 'B'
          row_range = upper(row_range)
        end
      end
      row = row_range.first

      col_data.each do |mod|
        if mod == 'L'
          col_range = lower(col_range)
        elsif mod == 'R'
          col_range = upper(col_range)
        end
      end
      col = col_range.first

      {
        row:     row,
        col:     col,
        seat_id: row * 8 + col
      }
    end

    seen_passes = boarding_passes.map do |pass|
      pass[:seat_id]
    end

    possible_passes = (0..(127 * 8 + 7)).to_a

    possible_passes = possible_passes - seen_passes

    missing_passes = (0..7).to_a + ((127 * 8)..(127 * 8 + 7)).to_a

    possible_passes = possible_passes - missing_passes

    possible_passes.find do |pass|
      pcol = pass % 8

      pcol.between?(1,6) && # Not at the row beginning or end
        seen_passes.include?(pass - 1) &&
        seen_passes.include?(pass + 1)
    end
  end

  def upper(range)
    range[(range.size/2.0).floor..-1]
  end

  def lower(range)
    range[0...(range.size/2.0).floor]
  end
end
