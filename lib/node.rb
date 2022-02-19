# frozen_string_literal: true

# Creates tree nodes and points to their children
class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def <=>(other)
    data <=> other.data
  end

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
