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

  def delete(value, root = @root)
    if root.nil?
      value
    elsif value < root.data
      if root.left_child.data == value
        if root.left_child.left_child.nil? && root.left_child.right_child.nil?
          root.left_child = nil
        end
      end
      delete(value, root.left_child)
    elsif value > root.data
      if root.right_child.data == value
        if root.right_child.left_child.nil? && root.right_child.right_child.nil?
          root.right_child = nil
        end
      end
      delete(value, root.right_child)
    end
  end

  def find(value, node = @root)
    if node.data == nil || node.data == value
      node
    elsif value < node.data
      find(value, node.left_child)
    elsif value > node.data
      find(value, node.right_child)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end