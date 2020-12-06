require_relative "../puzzle"
class Day02P1 < Puzzle
  def test_cases
    { # {input => expected}
     ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc'] => 2
    }
  end

  def solve(input, testing: false)
    valid_passwords = input.select do |rule|
      r = rule.match(/(?<min>\d+)-(?<max>\d+) (?<letter>[a-z]): (?<password>[a-z]+)/)
      freq = r[:password].chars.count { |c| c == r[:letter] }

      freq.between?(r[:min].to_i, r[:max].to_i)
    end

    valid_passwords.size
  end
end
