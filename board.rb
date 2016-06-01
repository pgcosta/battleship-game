class Board
  # some macros for the grid
  NO_BOAT = 0
  BOAT_PRESENT = 1
  ALREADY_HIT = -1

  attr_accessor :grid, :boats

  BOARD_SIZE = 6

  def initialize boats
    height = BOARD_SIZE
    width = BOARD_SIZE
    # initialize a 2d array with all values set to 0
    @grid = Array.new(height, NO_BOAT) { Array.new(width, NO_BOAT) }
    @boats = boats
  end

  # place boat on the board
  # boat will be placed from left to right or from top to bottom
  def place_boat boat, row, column, orientation: :horizontal
    raise "Out of bounds!" unless check_placement_bounds(boat.size, row, column, orientation)

    # lets mark the boat placement
    (0...boat.size).each do |offset|
      if orientation == :horizontal
        @grid[row][column + offset] = BOAT_PRESENT
      else
        @grid[row + offset][column] = BOAT_PRESENT
      end
    end
  end

  private

  # checks if it is possible to place a boat on the board within the bounds
  # ie: a boat size 2 placed horizontally on 0x0 is true
  # ie: a boat size 7 placed horizontally on 0x0 is false, because the grid is only size 6
  def check_placement_bounds boat_size, row, column, orientation
    if orientation == :horizontal
      return false if column + boat_size > BOARD_SIZE
    elsif orientation == :vertical
      return false if row + boat_size > BOARD_SIZE
    end
    true
  end
end