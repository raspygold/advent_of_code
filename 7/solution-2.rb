#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

class Circuit
  attr_accessor :connections

  def initialize(circuit_definition)
    @connections = {}

    prepare_connections(circuit_definition)
    connect_everything
  end

  private

  def prepare_connections(circuit_definition)
    circuit_definition.each do |connection_def|
      connection_def.strip! # Remove trailing \n

      source, operator, modifier, identifier = parse_connection(connection_def)

      create_connection(identifier, source, operator, modifier)
    end
  end

  def parse_connection(connection_def)
    left_right_regex = /(\w\W?.*) -> (.*)/
    inputs, output   = left_right_regex.match(connection_def)[1..2]

    inputs_regex  = /\A((\w*)\W?(AND|OR|LSHIFT|RSHIFT|NOT)\W(\w+))|(\w+)\z/
    parsed_inputs = inputs_regex.match(inputs)

    [parsed_inputs[2], parsed_inputs[3], parsed_inputs[4] || parsed_inputs[5], output]
  end

  def create_connection(identifier, source, operator, modifier)
    modifier = "3176" if identifier == "b" # Override the input to wire b
    @connections[identifier] = Connection.new(self, source, operator, modifier)
  end

  def connect_everything
    @connections.size.times do |i|
      @connections.values.reject { |connection| connection.value }.each(&:connect)

      break if @connections.values.all? { |connection| connection.value }
    end

    raise "Circuit cannot be completed" unless @connections.values.all? { |connection| connection.value }
  end

  class Connection < Struct.new(:circuit, :source, :operator, :modifier)
    attr_accessor :value

    def connect
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



circuit = Circuit.new(input)

p circuit.connections["a"].value
# => 14710
