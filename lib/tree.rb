# frozen_string_literal: true

require_relative 'node'
# Creates and stores a binary search tree
class Tree
  def initialize(array)
    @data = array.uniq.sort
    @data_end = @data.length - 1
    @bst = build_tree(@data, @data_end)
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
      root
    elsif value < root.data
      root.left_child = delete(value, root.left_child)
    elsif value > root.data
      root.right_child = delete(value, root.right_child)
    else
      if root.left_child.nil?
        return root.right_child
      elsif root.right_child.nil?
        return root.left_child
      else
        root.data = get_in_order_sucessor(root.right_child)
        root.right_child = delete(root.data, root.right_child)
      end
    end
    root
  end

  def get_in_order_sucessor(root)
    in_order = root.data
    until root.left_child.nil?
      in_order = root.left_child.data
      root = root.left_child
    end
    in_order
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

  def level_order(node = @root)
    queue = []
    array = []
    queue.push(node)
    until queue.empty?
      unless queue[0].nil?
        if block_given?
          yield queue[0]
        else
          array.push(queue[0].data)
        end
        queue.push(queue[0].left_child)
        queue.push(queue[0].right_child)
      end
      queue.shift
    end
    array
  end

  def inorder(node = @root, array = [], &block)
    if node.nil?
      array
    else
      inorder(node.left_child, array, &block)
      if block_given?
        yield node
      else
        array.push(node.data)
      end
      inorder(node.right_child, array, &block)
    end
  end

  def preorder(node = @root, array = [], &block)
    if node.nil?
      array
    else
      if block_given?
        yield node
      else
        array.push(node.data)
      end
      preorder(node.left_child, array, &block)
      preorder(node.right_child, array, &block)
    end
  end

  def postorder(node = @root, array = [], &block)
    if node.nil?
      array
    else
      postorder(node.left_child, array, &block)
      postorder(node.right_child, array, &block)
      if block_given?
        yield node
      else
        array.push(node.data)
      end
    end
  end

  def height(node = @root, count = 0, deepest_leaf = level_order(node).last)
    nil if node.nil?
    if deepest_leaf == node.data
      count
    elsif deepest_leaf < node.data
      count += 1
      height(node.left_child, count, deepest_leaf)
    elsif deepest_leaf > node.data
      count += 1
      height(node.right_child, count, deepest_leaf)
    end
  end

  def depth(node)
    height(@root, 0, node.data)
  end

  def balanced?
    (height(@root.left_child) - height(@root.right_child)).abs < 1
  end

  def rebalance
    return if balanced?

    tree_array = inorder
    tree_array_end = tree_array.length - 1
    @bst = build_tree(tree_array, tree_array_end)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
