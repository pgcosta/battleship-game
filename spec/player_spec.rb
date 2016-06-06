require_relative '../boat'
require_relative '../board'
require_relative '../player'

describe Player do
  it "should calculate the health of all the boats" do
    player = Player.new
    board = Board.new
    boat1 = Boat.new(3)
    boat2 = Boat.new(3)
    board.boats = [boat1, boat2]
    player.board = board

    expect(player.calculate_player_health).to eq(6)
  end
end