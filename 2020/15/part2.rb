require_relative "../puzzle"

class Day15P2 < Puzzle

  def test_cases
    { # {input => expected}
      '0,3,6' => 175594,
      '1,3,2' => 2578,
      '2,1,3' => 3544142,
      '1,2,3' => 261214,
      '2,3,1' => 6895259,
      '3,2,1' => 18,
      '3,1,2' => 362,
    }
  end

  def index_n(num, idx)
    @num_idxs[num] ||= [nil, nil]
    @num_idxs[num] << idx # Add one to the end
    @num_idxs[num].shift # Remove the first one
  end

  def prev_idx(num)
    prev_idx = @num_idxs[num] ? @num_idxs[num][0] : nil
  end

  def solve(input, testing: false)
    @num_idxs = {}
    last_num = nil

    # Set up initial state with starting numbers
    starting_nums = input.split(',').map(&:to_i)
    starting_nums.each.with_index { |n, i| index_n(n, i) }
    last_num = starting_nums.last

    (starting_nums.size...30_000_000).each do |i|
      prev_idx = @num_idxs[last_num] ? @num_idxs[last_num][0] : nil
      age = prev_idx.nil? ? 0 : (i - 1) - prev_idx
      index_n(age, i)
      last_num = age
    end

    return last_num
  end
end
