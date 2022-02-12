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
    return nil if array_start > array_end
    mid = (array_start + array_end) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, mid - 1, array_start)
    root.right_child = build_tree(array, array_end, mid + 1)
    @root = root
  end

  def insert(value, root = @root)
    if value == root.data
      value
    elsif value < root.data
      root.left_child = Node.new(value) if root.left_child.nil?
      insert(value, root.left_child)
    elsif value > root.data
      root.right_child = Node.new(value) if root.right_child.nil?
      insert(value, root.right_child)
    end
  end

  def delete(value)
    # search for value
    # return nil if value can't be found
    # if value is leaf, set root child to nil
    # if value has one child, point root to child, point value to nil
    # if value has two children, find inorder successor to node 
      # copy contents of inorder successor to node and delete in order successor
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end