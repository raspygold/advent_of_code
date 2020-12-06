require_relative "../puzzle"
class Day02P2 < Puzzle
  def test_cases
    { # {input => expected}
     ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc'] => 1
    }
  end

  def solve(input, testing: false)
    valid_passwords = input.select do |rule|
      r = rule.match(/(?<first>\d+)-(?<second>\d+) (?<letter>[a-z]): (?<password>[a-z]+)/)
      indexes = [r[:first], r[:second]].map { |i| i.to_i - 1 }
      indexes.map do |index|
        r[:password][index]
      end.count { |c| c == r[:letter] } == 1
    end

    valid_passwords.size
  end
end
