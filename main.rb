# frozen_string_literal: true

require_relative 'lib/tree'

random_num_array = (Array.new(15) { rand(1..100) })
my_tree = Tree.new(random_num_array)

print "\n"
puts my_tree.pretty_print
print "Balanced tree? #{my_tree.balanced?}\n\n"
puts  "Level order i: #{my_tree.level_order_i}"
puts  "Preoder:       #{my_tree.preorder}"
puts  "Inorder:       #{my_tree.inorder}"
print "Postorder:     #{my_tree.postorder}\n\n"

print "#{'=' * 90}\n\n"
my_tree.insert(102)
my_tree.insert(109)
my_tree.insert(113)
my_tree.insert(122)
puts "Inserted node: #{my_tree.find(102).data}"
puts "Inserted node: #{my_tree.find(109).data}"
puts "Inserted node: #{my_tree.find(113).data}"
puts "Inserted node: #{my_tree.find(122).data}"
print "\n\n"
puts my_tree.pretty_print
print "Balanced tree? #{my_tree.balanced?}\n\n"

print "#{'=' * 90}\n\n"
my_tree.rebalance
puts 'Rebalanced tree'
print "\n\n"
puts my_tree.pretty_print
print "Balanced tree? #{my_tree.balanced?}\n\n"
puts  "Level order r: #{my_tree.level_order_r}"
puts  "Preoder:       #{my_tree.preorder}"
puts  "Inorder:       #{my_tree.inorder}"
puts  "Postorder:     #{my_tree.postorder}"
