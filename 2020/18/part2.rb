require_relative "../puzzle"

class Day18P2 < Puzzle

  ACTIVE    = '#'
  INACTINVE = '.'
  CYCLES    = 6

  def test_cases
    { # {input => expected}
      ['1 + 2 * 3 + 4 * 5 + 6'] => 231,
      ['1 + (2 * 3) + (4 * (5 + 6))'] => 51,
      ['2 * 3 + (4 * 5)'] => 46,
      ['5 + (8 * 3 + 9 + 3 * 4 * 3)'] => 1445,
      ['5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'] => 669060,
      ['((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'] => 23340
    }
  end

  def solve_expression(expression)
    compact_expr = expression.gsub(/\s/,'')

    split_expr = expression.split(' ').map do |s|
      s =~ /[\+\-\*\/]/ ? s : s.to_i
    end

    ['+','*'].each do |op|
      loop do
        idx = split_expr.index(op)
        break unless idx

        n = split_expr[idx-1].send(op, split_expr[idx+1])
        split_expr.slice!(idx-1, 3)
        split_expr[idx-1, 0] = n
      end
    end

    split_expr.first
  end

  def resolve_parenthesis(expression)
    start_of_inner_expression = expression =~ /\(\d+ (\s?[\+\-\*\/]{1} \d+)+\)/
    end_of_inner_expression   = nil
    return expression unless start_of_inner_expression # no parens left

    length_of_inner_expression = expression[start_of_inner_expression...expression.size].index(')')
    inner_expression = expression[start_of_inner_expression, length_of_inner_expression+1]
    inner_expression_without_parens = inner_expression.gsub(/[\(\)]/, '')

    expression = expression.gsub(inner_expression, solve_expression(inner_expression_without_parens).to_s)

    resolve_parenthesis(expression)
  end

  def solve(input, testing: false)
    products = input.map do |line|
      solve_expression(resolve_parenthesis(line))
    end
    products.reduce(&:+)
  end
end
