class Boat
  MAX_SIZE = 3

  attr_accessor :size, :health, :orientation, :row, :column

  # orientation= :vertical | :horizontal
  def initialize size
    @size = size
    @health = size
  end

  # set the placement of the boat in the board
  #  set row, column and orientation of the boat
  def set_location row, column, orientation
    @row = row
    @column = column
    @orientation = orientation
  end

  # boat gets hit by a torpedo
  def take_hit
    @health -= 1
    @health
  end

  # given the coordinates of a shot, returns true if it was a shot miss, or false if it was a hit
  def shot_missed? row, column
    (0...@size).each do |offset|
      if @orientation == :horizontal
        return false if column == (@column+offset)
      elsif @orientation == :vertical
        return false if row == (@row+offset)
      end
    end
    true
  end

  private

  # given the coordinates of a shot, return if it is possible that the boat was hit
  def possible_hit? row, column
    if @orientation == :horizontal
      return @row == row
    elsif @orientation == :vertical
      return @column == column
    end
  end

end