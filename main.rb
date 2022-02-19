require_relative './lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Is the tree balanced: #{tree.balanced?}"
puts 'Elements in level order:'
p tree.level_order
puts 'Elements in preorder:'
p tree.preorder
puts 'Elements in postorder:'
p tree.postorder
puts 'Elements in order:'
p tree.inorder
puts 'Adding elements to unbalance tree'
tree.insert(123)
tree.insert(32423)
tree.insert(102)
tree.insert(400)
tree.pretty_print
puts "Is the tree balanced: #{tree.balanced?}"
puts 'Rebalancing tree.'
tree.rebalance
tree.pretty_print
puts "Is the tree balanced: #{tree.balanced?}"
puts 'Elements in level order:'
p tree.level_order
puts 'Elements in preorder:'
p tree.preorder
puts 'Elements in postorder:'
p tree.postorder
puts 'Elements in order:'
p tree.inorder
