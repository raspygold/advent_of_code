require_relative "../puzzle"
require 'set'

class Day08P1 < Puzzle
  def test_cases
    { # {input => expected}
      [
        'nop +0',
        'acc +1',
        'jmp +4',
        'acc +3',
        'jmp -3',
        'acc -99',
        'acc +1',
        'jmp -4',
        'acc +6'
      ] => 5
    }
  end

  def solve(input, testing: false)
    instructions = input.dup
    instructions_executed = Set.new
    accumulator = 0
    instruction_idx = 0

    ops = {
      'acc' => Proc.new { |arg| accumulator += arg },
      'jmp' => Proc.new { |arg| instruction_idx += (arg - 1) },
      'nop' => Proc.new { |arg| arg }
    }

    loop do
      break if instructions_executed.include?(instruction_idx)

      op, arg = instructions[instruction_idx].split(" ")
      arg = arg.to_i

      instructions_executed << instruction_idx
      ops[op].call(arg)

      instruction_idx += 1
    end

    accumulator
  end
end
