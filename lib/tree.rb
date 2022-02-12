require_relative 'node'
require 'pry-byebug'
class Tree
  def initialize(array)
    @data = array.uniq.sort
    p @data
    @data_end = @data.length - 1
    bst = build_tree(@data, @data_end)
  end

  def build_tree(array, array_end, array_start = 0)
    #binding.pry
    return nil if array_start > array_end
    mid = (array_start + array_end) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, mid - 1, array_start)
    root.right_child = build_tree(array, array_end, mid + 1)
    @root = root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end