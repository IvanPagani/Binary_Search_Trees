# frozen_string_literal: true

class Node
  include Comparable

  attr_accessor :left, :data, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  # This method is required by the Comparable module.
  # It compares this node's data to another node's data,
  # allowing us to use <, >, ==, etc. on Node objects.
  def <=>(other)
    data <=> other.data
  end
end
