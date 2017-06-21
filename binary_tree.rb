module BinaryTree

$root

class Node
  attr_accessor :value, :parent, :child_l, :child_r
  
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end

def self.build_tree(data, node = $root)
  return $root if data.empty?
  if $root == nil
    mid = tree_average(data)
    $root = Node.new(data[mid])
    node = $root
    data.delete_at(mid)
  end
  current_node = Node.new(data, node)
  
  if node.value >= data[0]
    if node.child_l == nil
      node.child_l = Node.new(data[0], node)
    else
      build_tree(data, node.child_l)
    end
  elsif node.value < data[0]
    if node.child_r == nil
      node.child_r = Node.new(data[0], node)
    else
      build_tree(data, node.child_r)
    end
  end
  
  data.shift
  build_tree(data)
end

# returns the nearest to average member of the dataset
# for a more balanced tree
def self.tree_average(ary)
  return 0 if ary.length == 0
  
  sum, mid = 0, 0
  
  ary.each { |x| sum += x}
  
  average = sum / ary.length
  nearest = (average - ary[0]).abs
  
  ary.each_with_index do |x,i|
    if (average - x).abs < nearest
      mid = i
      nearest = (average - x).abs
    end
  end
  
  return mid
end

def self.breadth_first_search(value)
  return nil if $root == nil
  return $root if $root.value == value
  
  queue = [$root]
  
  while !queue.empty?
    node = queue[-1]
    if node.child_l != nil
      queue.unshift(node.child_l)
      return node.child_l if node.child_l.value == value
    end
      
    if node.child_r != nil
      queue.unshift(node.child_r)
      return node.child_r if node.child_r.value == value
    end
    
    queue.pop
  end
end

def self.depth_first_search(value)
  return nil if $root == nil
  
  stack = [$root]
  while !stack.empty?
    node = stack.pop
    return node if node.value == value
    stack << node.child_r if node.child_r != nil
    stack << node.child_l if node.child_l != nil
  end
    
  return nil
end

def self.dfs_rec(value, node = $root)
  return nil if node == nil
  return node if node.value == value
  left = dfs_rec(value, node.child_l) if node.child_l != nil
  right = dfs_rec(value, node.child_r) if node.child_r != nil
  left or right
end

# prints a crummy representation of the tree
def self.tree_print(node)
  if node != nil
    print "\n"
    node.parent != nil ? parent = node.parent.value : parent = "none"
    puts "| #{node.value} | Parent: #{parent}"
    puts "Child Left: #{node.child_l.value}" if node.child_l != nil
    puts "Child Right: #{node.child_r.value}" if node.child_r != nil
    left = tree_print(node.child_l)
    right = tree_print(node.child_r)
  end
end

end
