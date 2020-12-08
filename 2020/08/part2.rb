require_relative "../puzzle"
require 'set'

class Day08P2 < Puzzle
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
      ] => 8
    }
  end

  def solve(input, testing: false)
    instructions_to_flip = []
    input.each.with_index do |instruction, i|
      instructions_to_flip << i if instruction =~ /(jmp)|(nop)/
    end
    accumulator = 0

    instructions_to_flip.each do |instruction_to_flip|
      instructions = input.dup
      accumulator  = 0

      # Flip the operation
      original_operation = instructions[instruction_to_flip].split(' ').first
      swapped_operation  = original_operation == 'jmp' ? 'nop' : 'jmp'
      instructions[instruction_to_flip] = instructions[instruction_to_flip].sub(original_operation, swapped_operation)

      instructions_executed = Set.new
      instruction_idx = 0

      ops = {
        'acc' => Proc.new { |arg| accumulator += arg },
        'jmp' => Proc.new { |arg| instruction_idx += arg },
        'nop' => Proc.new { |arg| arg }
      }

      loop do
        break if instructions_executed.include?(instruction_idx) || instruction_idx >= instructions.size

        op, arg = instructions[instruction_idx].split(' ')
        arg = arg.to_i

        instructions_executed << instruction_idx
        ops[op].call(arg)

        instruction_idx += 1 unless op == 'jmp'
      end
      break if instruction_idx >= instructions.size
    end

    accumulator
  end
end
