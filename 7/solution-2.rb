#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

class Circuit
  attr_accessor :connections

  def initialize
    @connections = {}
  end

  def create_connection(identifier, source, operator, modifier)
    modifier = "3176" if identifier == "b" # Override the input to wire b
    @connections[identifier] = Connection.new(self, source, operator, modifier)
  end

  class Connection < Struct.new(:circuit, :source, :operator, :modifier)
    attr_accessor :value

    def calculate_value
      return if @value

      source_value   = find_value(source)
      modifier_value = find_value(modifier)

      return unless modifier_value # required by every type of circuit connection

      @value = case operator
      when "AND"
        return unless source_value
        source_value & modifier_value
      when "OR"
        return unless source_value
        source_value | modifier_value
      when "LSHIFT"
        return unless source_value
        source_value << modifier_value
      when "RSHIFT"
        return unless source_value
        source_value >> modifier_value
      when "NOT"
        ~modifier_value
      else
        modifier_value
      end
    end

    def find_value(operand)
      return nil if operand == "" # Empty string means not present
      return operand.to_i if operand.to_i.to_s == operand # static value, not a wire connection — i.e. integer,

      connection = circuit.connections[operand]

      connection ? connection.value : nil
    end

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

  source, operator, modifier, identifier = parse_circuitry(circuitry)

  circuit.create_connection(identifier, source, operator, modifier)
end


loop do
  circuit.connections.values.reject { |connection| connection.value }.each(&:calculate_value)

  break if circuit.connections.values.all? { |connection| connection.value }
end

p circuit.connections["a"].value
# => 3176
