require_relative "../puzzle"

class Day18P1 < Puzzle

  ACTIVE    = '#'
  INACTINVE = '.'
  CYCLES    = 6

  def test_cases
    { # {input => expected}
      ['1 + 2 * 3 + 4 * 5 + 6'] => 71,
      ['1 + (2 * 3) + (4 * (5 + 6))'] => 51,
      ['2 * 3 + (4 * 5)'] => 26,
      ['5 + (8 * 3 + 9 + 3 * 4 * 3)'] => 437,
      ['5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'] => 12240,
      ['((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'] => 13632
    }
  end

  def solve_expression(expression)
    compact_expr = expression.gsub(/\s/,'')

    n = compact_expr.slice!(0...compact_expr.index(/[\+\-\*\/]/)).to_i
    loop do
      break if compact_expr.empty?
      op = compact_expr.slice!(0)
      next_op_idx = compact_expr.index(/[\+\-\*\/]/) || compact_expr.size
      x =  compact_expr.slice!(0...next_op_idx).to_i

      n = n.send(op, x)
    end

    n
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
