require 'byebug'
require_relative 'player'
require_relative 'board'
require_relative 'boat'

module Game

  extend self

  def input_players player1, player2
    puts "Player 1 name: "
    player1.name = gets.delete("\n")

    puts "Player 2 name: "
    player2.name = gets

    return player1, player2
  end

  def input_boats player
    puts "how many boats?"
    n = gets
    n = n.to_i

    (0...n).each do |i|
      size, row, column, orientation = 2,0,0,:horizontal#ask_boat_params(player)

      boat = Boat.new size
      player.board.place_boat(boat, row, column, orientation: orientation.to_sym)
    end
    player
  end

  def ask_boat_params(player)
    size = 0
    while size.to_i < 1 || size.to_i > 3
      puts "Boat size? ie: 2 or 3"
      size = gets
    end
    puts "Row to place boat?"
    row = gets
    puts "Column to place boat?"
    column = gets
    puts "Orientation to place boat? ('horizontal', 'vertical')"
    orientation = gets

    return size.to_i, row.to_i, column.to_i, orientation.to_sym

    player
  end


  def make_play player_defend
    puts "Attack #{player_defend.name} board!"
    puts "Row: "
    row = gets
    puts "Column: "
    column = gets

    player_defend.board.mark_hit(row.to_i, column.to_i)
    player_defend.health = player_defend.calculate_player_health

    puts "#{player_defend.name} attacked on " + row + ', ' + column
    puts "#{player_defend.name} remaining health: #{player_defend.health}"
    player_defend
  end

  def main_loop
    player1 = Player.new
    player2 = Player.new

    player1, player2 = Game.input_players(player1, player2)
    puts "#{player1.name}: input your boats:"
    player1 = Game.input_boats(player1)
    puts "#{player2.name}: input your boats:"
    player2 = Game.input_boats(player2)

    player1.health = player1.calculate_player_health
    player2.health = player2.calculate_player_health

    puts "Game start"

    while player1.health > 0 && player2.health > 0
      player1 = make_play(player1)
      player2 = make_play(player2)
    end

    puts "Game over!"
    puts player1.name + " health: " + player1.health
    puts player2.name + " health: " + player1.health
  end
end



