#so what's the full breakdown here?

#we have several components we're working with:
  #a game board -- an array of arrays correlating to coordinates on a game board
  #a "knight", which is essentially just a starting coordinate in the grid?
  #we need a way to keep track of legal moves the knight can make. In other words, 
  #from any given space, we need to keep track of all other spaces that can be moved to.

#in practical terms, this means that a knight will have its own specific tree of legal moves based on its movement algorithm.
#so for a knight, that's a directed cyclic graph with some nodes having a max of 8 child nodes. Adjacency matrix maybe?
#those moves won't ever change, the only thing that changes is the knight's current coordinates, which can be displayed on the saved grid.


#for the game board, we need an array of arrays. 

#do we need a knight class? Not really. What the knight is is just a record of possible related moves using the right algorithm, right?

class Cell

  attr_accessor :position, :data, :moves

  def initialize(data = 0)
    @position = []
    @data = data
    @moves = []
  end

end


class Board

  attr_reader :grid

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

  public

  def find_knight_moves(root)
    
    return root if root == nil
    return root if root.data == 1

    y, x = root.position[0], root.position[1]
    puts "y is #{y}"
    puts "x is #{x}"

    possible_moves = []
    valid_moves = []

    possible_moves << [(y + 2), (x - 1)]
    possible_moves << [(y + 2), (x + 1)]
    possible_moves << [(y - 2), (x - 1)]
    possible_moves << [(y - 2), (x + 1)]
    possible_moves << [(y + 1), (x - 2)]
    possible_moves << [(y + 1), (x + 2)]
    possible_moves << [(y - 1), (x - 2)]
    possible_moves << [(y - 1), (x + 2)]

    puts "possible_moves is #{possible_moves}"

    possible_moves.each do |move| 
      if (move[0] < 0 || move[1] < 0) || (move[0] > 7 || move[1] > 7) #|| @grid[move[0]][move[1]].data == 1
        next
      else
        valid_moves << move
      end
    end

    puts "valid_moves is #{valid_moves}"

    valid_moves.each do |move|
      puts "Found one! Adding #{move} to legal moves of #{root.position}"
      root.moves << move
      find_knight_moves(@grid[move[0]][move[1]])
    end

------------------------ PAUSED HERE! FIX THIS METHOD! GENERATES AN INFINITE LOOP ----------------------

    root.data = 1

    return root
  end

end

# class Knight

#   def initialize
#     @possible_moves = find_knight_moves([0, 0])
#   end

#   def build_possible_moves(root = [0, 0])

#     #here we need to pass in the game board, and build a tree off of it to determine all possible moves of each space in the entire grid
#     #the tree will start with a root cell and find all legal moves from that space, and then save them as child nodes for that space.
#     #so we should be able to recursively take a node and find it's children.
#     #that should look something like:

#     #base case is if the passed node doesn't exist or if it isn't a legal move

#     return root if root == nil

#     #we only continue the recursion if a node is determined tgame_board.knight_moves = find_knight_moves(@grid[0][0]) be a legal move. if it isn't, we return nothing or nil or something.
#     if legal_move?(node)
#       root.moves << node
#       #---------- PAUSED METHOD HERE --------------

#     end
#   end

#   #let's start with a more granular approach. Let's just take a node, and recursively find its available moves








game_board = Board.new


game_board.display_board

