class Boat
  attr_accessor :size, :health, :orientation, :row, :column

  # orientation= :vertical | :horizontal
  def initialize size, orientation: :vertical
    @size = size
    @health = size
    @orientation = orientation
  end

  def set_location row, column
    @row = row
    @column = column
  end

  # boat gets hit by a torpedo
  def take_hit
    @health -= 1
    @health
  end
end