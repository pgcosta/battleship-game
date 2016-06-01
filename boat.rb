class Boat
  attr_accessor :size, :health, :position

  def initialize size
    @size = size
    @health = size
    @position = position
  end

  # boat gets hit by a torpedo
  def take_hit
    @health -= 1
  end

  def position
  end
end