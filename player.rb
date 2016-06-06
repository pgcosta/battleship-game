require_relative 'board'

class Player
  attr_accessor :name, :board, :health

  def initialize
    @board = Board.new
  end

  def calculate_player_health
    @board.boats.inject(0) do |health, boat|
      health += boat.health
    end
  end
end