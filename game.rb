require_relative 'player'
require_relative 'board'
require_relative 'boat'

module Game

  extend self

  def input_players player1, player2
    print "Player 1 name: "
    player1.name = gets.delete("\n")

    print "Player 2 name: "
    player2.name = gets.delete("\n")

    return player1, player2
  end

  def input_boats player
    print "#{player.name } how many boats: "
    n = gets.delete("\n")
    n = n.to_i

    (0...n).each do |i|
      size, row, column, orientation = ask_boat_params(player) #2,0,0,:horizontal

      boat = Boat.new size
      player.board.place_boat(boat, row, column, orientation: orientation.to_sym)
    end
    player
  end

  # Ask the player to input the boats location
  def ask_boat_params(player)
    size = 0
    while size.to_i < 1 || size.to_i > 3
      print "Boat size? ie: 2 or 3 --> "
      size = gets.delete("\n")
    end
    print "Row to place boat: "
    row = gets.delete("\n")
    print "Column to place boat: "
    column = gets.delete("\n")
    puts "Orientation to place boat? ('horizontal', 'vertical')"
    orientation = gets.delete("\n")

    return size.to_i, row.to_i, column.to_i, orientation.to_sym

    player
  end


  # handles a play, when a player attacks another
  def make_play player_defend, player_attack
    puts "*"*20
    puts "#{player_attack.name}(#{player_attack.health}) attacks #{player_defend.name}(#{player_defend.health})!"
    print "Row: "
    row = gets.delete("\n")
    print "Column: "
    column = gets.delete("\n")

    player_defend.board.mark_hit(row.to_i, column.to_i)
    player_defend.health = player_defend.calculate_player_health

    puts "#{player_defend.name} attacked on " + row + ', ' + column
    puts "#{player_defend.name} remaining health: #{player_defend.health}"
    puts "*"*20
    puts ''
    player_defend
  end

  # given two players returns the one with the most health
  #  returns player one by default if a draw
  def winner player1, player2
    player1.health > player2.health ? player1 : player2
  end

  # games main loop. When a player wins, it exits this method
  def main_loop
    player1 = Player.new
    player2 = Player.new

    puts "Welcome! Board size: " + Board::BOARD_SIZE.to_s
    puts "Please note that this is a Nerds board: coordinates range from 0 - " + (Board::BOARD_SIZE-1).to_s

    player1, player2 = Game.input_players(player1, player2)
    puts "#{player1.name}: input your boats:"
    player1 = Game.input_boats(player1)
    puts "#{player2.name}: input your boats:"
    player2 = Game.input_boats(player2)

    player1.health = player1.calculate_player_health
    player2.health = player2.calculate_player_health

    puts "Game start"

    while player1.health > 0 && player2.health > 0
      player2 = make_play(player2, player1)
      player1 = make_play(player1, player2)
    end

    puts "Game over!"
    puts player1.name + " health: " + player1.health.to_s
    puts player2.name + " health: " + player1.health.to_s

    puts "Winner: " + winner(player1, player2).name
  end
end

Game::main_loop



