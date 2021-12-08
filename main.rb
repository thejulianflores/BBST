require_relative 'script'

class Node 
  attr_accessor :data, :left, :right

  def initialize( value )
    @data = value
    @left = nil
    @right = nil
  end

end

class Tree 

  def initialize( data )
    @data = data.uniq.sort
    @root = build_tree( @data )
  end

  def build_tree( data, first = 0, last = data.length - 1 )
    if first > last
      return nil
    end

    mid = ( (first + last) / 2 )
    current_root = Node.new( data[ mid ] )
    current_root.left = build_tree( data, first, mid - 1 )
    current_root.right = build_tree( data, mid + 1, last )
    current_root
  end

  def insert( value, node = @root )
    if node.nil?
      return Node.new( value )
    end

    if value < node.data
      node.left = insert( value, node.left )
    elsif value > node.data
      node.right = insert( value, node.right )
    end

    node
  end

  def delete( value, node = @root )
    if node.nil?
      return node
    end

    if value < node.data
      node.left = delete( value, node.left )
    elsif value > node.data
      node.right = delete( value, node.right )
    end

    if value == node.data
      if node.left.nil?
        node = node.right
      elsif node.right.nil?
        node = node.left
      else
        node.data = min_val( node.right )
        node.right = delete( node.data, node.right )
      end
    end

    node

  end

  def find( value, node = @root )
    if node.nil? || node.data == value
      return node
    end

    if value < node.data
      node = find( value, node.left )
    elsif value > node.data
      node = find( value, node.right )
    end
    node
  end

  def level_order( queue = [@root], arr = [], &block )
    if queue.empty?
      return
    end
    
    queue.push( queue[0].left ) if queue[0].left
    queue.push( queue[0].right ) if queue[0].right
    if block_given?
      yield queue[0]
    else
      arr.push( queue[0].data )
    end
    queue.shift
    level_order( queue, arr, &block )

    return arr if !block_given?
  end

  def inorder( node = @root, arr = [], &block )
    if node.nil?
      return
    end

    inorder( node.left, arr, &block ) if node.left

    block_given? ? ( yield node ) : arr.push( node.data )

    inorder( node.right, arr, &block ) if node.right
    
    return arr unless block_given?

  end

  def preorder( node = @root, arr = [], &block )
    return if node.nil?

    block_given? ? ( yield node ) : arr.push( node.data )
    preorder( node.left, arr, &block ) if node.left
    preorder( node.right, arr, &block ) if node.right

    return arr unless block_given?
  end

  def postorder( node = @root, arr = [], &block )
    return if node.nil?

    postorder( node.left, arr, &block )
    postorder( node.right, arr, &block )
    block_given? ? ( yield node ) : arr.push( node.data )

    return arr unless block_given?
  end

  def height( node = @root )
    return 0 if node.nil?
    
    left = node.left ? height( node.left ) : 0
    right = node.right ? height( node.right ) : 0

    left > right ?  left + 1 :  right + 1
  end


  def depth( target_node = @root , current_node = @root, starting_height = 0)
    return starting_height if target_node == @root 
    return nil if  target_node.nil?

    if target_node.data < current_node.data
      starting_height = depth( target_node, current_node.left, starting_height + 1 )
    elsif target_node.data > current_node.data
      starting_height = depth( target_node, current_node.right, starting_height + 1 )
    end

    starting_height 
  end

  def balanced?
    arr = []
    inorder{ |node| arr.push(( height(node.left) - height(node.right) ).abs <= 1) }
    !arr.include?(false)
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

test