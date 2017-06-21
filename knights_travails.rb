class Node
  attr_accessor :location, :neighbors
  
  def initialize(location)
    @location = location
    @neighbors = []
    generate_neighbors
  end
  
  def generate_neighbors
    moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    
    moves.each do |x,y|
      if position_check(@location[0], x) and position_check(@location[1], y)
        @neighbors.push([@location[0] + x,@location[1] + y])
      end
    end
  end
  
  def position_check(value1, value2, bounds = [-1,8])
    if value1 + value2 > bounds[0] and value1 + value2 < bounds[1]
      return true
    end
    false
  end
  
end

# Makes an array of nodes with coordinates 8x8
def make_nodes(nodes = [])
  positions = []
  (0..7).each {|x| (0..7).each {|i| positions << [x,i] }}
  
  positions.each do |x|
    nodes << Node.new(x)
  end
  nodes
end

# Makes an array of moves with distance starting from
# given locatation
def build_paths(start)
  step = 0
  visited = []
  unvisited = [[board_node_by_location(start),step]]
  
  while !unvisited.empty?
    node = unvisited[0][0]
    step = unvisited[0][1] + 1
    
    node.neighbors.each do |x|
      if not_visited(board_node_by_location(x),visited, unvisited)
        unvisited << [board_node_by_location(x),step]
      end
    end
    visited << unvisited.shift
  end
  return visited
end

# Helper function checks if node has been processed
def not_visited(node, visited, unvisited)
  visited.each do |x,i|
    return false if x == node
  end
  
  unvisited.each do |x,i|
    return false if x == node
  end
  true
end

# Helper function returns node at given coordinates
def board_node_by_location(location)
  $board.each { |x| return x if x.location == location }
  return nil
end

def knight_moves(location, target)

  paths = build_paths(location)
  step_distance = -1
  current_neighbors = []
  steps = []
  

  # find target node in graph, get distance
  paths.each do |node, distance|
    if node.location == target
      step_distance = distance
      steps.unshift(node.location)
      current_neighbors = node.neighbors
      break
    end
  end
  
  while step_distance != 0
  
    paths.each do |node, distance|
      if distance == step_distance - 1
        current_neighbors.each do |x|
          if node.location == x
            step_distance = distance
            steps.unshift(node.location)
            current_neighbors = node.neighbors
            break
          end
        end
      end
    end
    
  end
  
  puts "Move accomplished in #{steps.length - 1} steps."
  steps.each {|x| print x.to_s + "\n"}
end

$board = make_nodes

knight_moves([5,2],[7,7])
