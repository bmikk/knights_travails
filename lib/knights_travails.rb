
class Cell

  attr_accessor :position, :data, :moves, :visited

  def initialize(data = 0)
    @position = []
    @data = data
    @moves = []
    @visited = 0
  end

end

class Board

  attr_reader :grid, :knight_moves

  def initialize
    @grid = create_grid
    @knight_moves = find_knight_moves(@grid[0][0])
  end

  def create_grid
    grid = blank_grid()
    return set_coordinates(grid)
  end

  def blank_grid
    return Array.new(8) { Array.new(8) { Cell.new } }
  end

  def set_coordinates(array)
    array.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        cell.position = [row_index, cell_index]
      end
    end
  end

  def display_board
    @grid.each do |row|
      row_cells = []
      row.each do |cell|
        row_cells << cell.position
      end
      p row_cells
      puts
    end
  end

  #Takes a root node and recursively finds all the other nodes around it that would count as a legal move.
  def find_knight_moves(root)
    
    #base case is if the root doesn't exist or if it's already been covered.
    return root if root == nil
    return root if root.data == 1

    #create local variables for the position's coordinates.
    y, x = root.position[0], root.position[1]

    #create local variables to store working array values
    possible_moves = []
    valid_moves = []

    #finds all possible moves that a knight would have from the root node
    possible_moves << [(y + 2), (x - 1)]
    possible_moves << [(y + 2), (x + 1)]
    possible_moves << [(y - 2), (x - 1)]
    possible_moves << [(y - 2), (x + 1)]
    possible_moves << [(y + 1), (x - 2)]
    possible_moves << [(y + 1), (x + 2)]
    possible_moves << [(y - 1), (x - 2)]
    possible_moves << [(y - 1), (x + 2)]

    #determines if each possible node is a valid move, and saves it if it is
    possible_moves.each do |move| 
      if (move[0] < 0 || move[1] < 0) || (move[0] > 7 || move[1] > 7)
        next
      else
        valid_moves << move
      end
    end

    #now that we've found all the valid moves for a node, marks the data flag showing we've covered the root node
    root.data = 1

    #Next, recursively finds the valid moves of each of the root node's valid children.
    valid_moves.each do |move|
      root.moves << move
      find_knight_moves(@grid[move[0]][move[1]])
    end

    return root
  end

  def set_not_visited
    @grid.each do |row|
      row.each do |cell|
        cell.visited == 0 if cell.visited != 0
      end
    end
  end

  def breadth_first_traversal(start_cell, target_cell)

    root = @grid[start_cell[0]][start_cell[1]]
    puts "Starting at #{root.position}"
    puts "Looking for #{target_cell}"

    #mark every cell as "not visited"
    set_not_visited()

    #create a queue for BFS
    queue = []

    #mark the root node as "visited" and enqueue it
    root.visited = 1
    queue << root.position

    path = []

    while queue.empty? == false do
      node = queue.shift
      path << node
      if @grid[node[0]][node[1]] == @grid[target_cell[0]][target_cell[1]]
        puts "Made it! Ending search."
        break
      else
        @grid[node[0]][node[1]].moves.each do |move|
          cell = @grid[move[0]][move[1]]
          if cell.visited == 0
            queue << cell.position
            cell.visited = 1
          end
        end
      end
    end

    puts "Your path is"
    p path



  end




end








game_board = Board.new


game_board.display_board

game_board.breadth_first_traversal([0, 0], [3, 3])



