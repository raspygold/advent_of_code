require_relative "../puzzle"
class Day05P1 < Puzzle
  def test_cases
    { # {input => expected}
      ['FBFBBFFRLR'] => 357,
      ['BFFFBBFRRR'] => 567,
      ['FFFBBBFRRR'] => 119,
      ['BBFFBBFRLL'] => 820,
      [
        'BFFFBBFRRR',
        'FFFBBBFRRR',
        'BBFFBBFRLL'
      ] => 820
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

    boarding_passes.map do |pass|
      pass[:seat_id]
    end.sort.reverse.first
  end

  def upper(range)
    range[(range.size/2.0).floor..-1]
  end

  def lower(range)
    range[0...(range.size/2.0).floor]
  end
end
