def test
    arr = Array.new(15){rand(1..100)}
    tree = Tree.new(arr)
    tree.pretty_print
    puts "-------------- Balanced? --------------"
    puts tree.balanced?
    puts "-------------- Level Order? --------------"
    puts tree.level_order
    puts "-------------- In Order? --------------"
    puts tree.inorder
    puts "-------------- Pre Order? --------------"
    puts tree.preorder
    puts "-------------- Post Order? --------------"
    puts tree.postorder
  
    5.times do
      tree.insert( rand(100..1000) )
    end
  
    tree.pretty_print
    puts "-------------- Balanced? --------------"
    puts tree.balanced?
  
    tree.rebalance
  
    tree.pretty_print
    puts "-------------- Balanced? --------------"
    puts tree.balanced?
  
    puts "-------------- Level Order? --------------"
    puts tree.level_order
    puts "-------------- In Order? --------------"
    puts tree.inorder
    puts "-------------- Pre Order? --------------"
    puts tree.preorder
    puts "-------------- Post Order? --------------"
    puts tree.postorder
  end
  