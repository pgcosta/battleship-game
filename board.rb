class Board

  attr_accessor :grid

  def initialize
    height = 6
    width = 6
    @grid = Array.new(height) { Array.new(width) }
  end
end