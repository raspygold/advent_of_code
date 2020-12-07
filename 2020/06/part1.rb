require_relative "../puzzle"
class Day06P1 < Puzzle
  def test_cases
    { # {input => expected}
      ['abcx'] => 4,
      ['abcy'] => 4,
      ['abcz'] => 4,
      [
        'abcx',
        'abcy',
        'abcz'
      ] => 6,
      [
        'abc',
        '',
        'a',
        'b',
        'c',
        '',
        'ab',
        'ac',
        '',
        'a',
        'a',
        'a',
        'a',
        '',
        'b'
      ] => 11
    }
  end

  def solve(input, testing: false)
    group_answers = input.join('\n').split('\n\n').map { |p| p.gsub('\n', '')}

    group_answers.map do |answers|
      answers.chars.uniq.size
    end.reduce(&:+)
  end
end
