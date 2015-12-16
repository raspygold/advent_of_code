#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

class Circuit
  attr_accessor :wires

  def initialize
    @wires = {}
  end

  def assign_value(input, output)
    @wires[output] = input
  end

  def value(wire)
    @wires[wire]
  end
end


def parse_circuitry(input)
  left_right_regex = /(\w\W?.*) -> (.*)/
  matching = left_right_regex.match(input)

  left  = matching[1]
  right = matching[2]

  left_regex = /\A((\w*)\W?(AND|OR|LSHIFT|RSHIFT|NOT)\W(\w+))|(\w+)\z/
  operation = left_regex.match(left)

  [operation[2], operation[3], operation[4] || operation[5], right]
end

circuit = Circuit.new

input.each.with_index do |circuitry, i|
  circuitry.strip! # Remove trailing \n
  operand1, operator, operand2, output = parse_circuitry(circuitry)

  case operator
  when "AND"
    next unless circuit.value(operand1) && circuit.value(operand2)
    circuit.assign_value(circuit.value(operand1) & circuit.value(operand2), output)
    # p "AND"
  when "OR"
    next unless circuit.value(operand1) && circuit.value(operand2)
    circuit.assign_value(circuit.value(operand1) | circuit.value(operand2), output)
    # p "OR"
  when "LSHIFT"
    next unless circuit.value(operand1)
    circuit.assign_value(circuit.value(operand1) << operand2.to_i, output)
    # p "LSHIFT"
  when "RSHIFT"
    next unless circuit.value(operand1)
    circuit.assign_value(circuit.value(operand1) >> operand2.to_i, output)
    # p "RSHIFT"
  when "NOT"
    next unless circuit.value(operand2)
    assign_value(~operand2, output)
    p "NOT"
  else # No operator
    is_int = operand2.to_i.to_s == operand2
    value = is_int ? operand2.to_i : circuit.value(operand2)

    next unless value
    circuit.assign_value(value, output)
  end

  puts circuit.wires

  # p operator, "Made it through the block"

end

# => 543903
