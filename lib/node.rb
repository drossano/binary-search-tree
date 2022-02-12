class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child
  def <=>(other_node)
    data <=> other_node.data
  end
  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end