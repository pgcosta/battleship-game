require_relative 'boat'
class Board
  # some macros for the grid
  NO_BOAT = 0
  BOAT_PRESENT = 1
  HIT = -1

  attr_accessor :grid, :boats

  BOARD_SIZE = 6

  def initialize
    height = BOARD_SIZE
    width = BOARD_SIZE
    # initialize a 2d array with all values set to 0
    @grid = Array.new(height, NO_BOAT) { Array.new(width, NO_BOAT) }
    @boats = []
  end

  # place boat on the board
  # boat will be placed from left to right or from top to bottom
  def place_boat boat, row, column, orientation: :horizontal
    # check if boat can be placed on board
    raise "Out of bounds!" unless check_placement_bounds(boat.size, row, column, orientation)
    raise "Cannot place boat here. Boats overlapped!" unless check_free_space(boat.size, row, column, orientation)

    # place boat on board
    boat.set_location(row, column, orientation)
    # lets mark the boat placement on the board
    (0...boat.size).each do |offset|
      if orientation == :horizontal
        @grid[row][column + offset] = BOAT_PRESENT
      else
        @grid[row + offset][column] = BOAT_PRESENT
      end
    end
    @boats << boat
  end

  # mark a hit on the board
  def mark_hit row, column
    mark_boat(row, column) if @grid[row][column] == BOAT_PRESENT
    @grid[row][column] = HIT
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

  # Check if there is free space to place the boat
  #  ie: boats do not overlap
  def check_free_space boat_size, row, column, orientation
    if orientation == :horizontal
      (0...boat_size).each do |column_offset|
        return false if @grid[row][column + column_offset] == BOAT_PRESENT
      end
    else
      (0...boat_size).each do |row_offset|
        return false if @grid[row + row_offset][column] == BOAT_PRESENT
      end
    end
    true
  end

  # method to, given the coordinates of the shot, find if a boat is placed in there
  #  if a boat is present, make it take a hit
  def mark_boat row, column
    max_offset = Boat::MAX_SIZE

    @boats.each do |boat|
      unless boat.shot_missed?(row, column)
        boat.take_hit
      end
    end
  end

end