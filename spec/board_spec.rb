require_relative 'spec_helper'

describe Board do
  let(:board) {Board.new}

  describe "initializer" do
    it "should initialize a new grid" do
      expect(board.grid.class).to eq(Array)
    end

    it "should initialize a new grid with height of 6" do
      # height must be 6
      expect(board.grid.size).to eq(6)
    end

    it "should initialize a new grid with width of 6" do
      expect(board.grid[1].size).to eq(6)
    end

    # the boundaries are 6x6
    it "should initialize a new grid within the boundaries" do
      expect(board.grid[5][5]).to eq(0)
      # [7][7] should not exist, and throw an error
      expect {
        board.grid[6][6]
      }.to raise_error
    end
  end

  describe "place_boat" do
    # check if it places the boat correctly on the grid horizontally
    it "should set on the grid the boat placement" do
      boat = Boat.new(2)
      boats = [boat]
      board = Board.new
      board.boats = boats

      board.place_boat(boat, 0, 0, orientation: :horizontal)

      expect(board.grid[0][0]).to eq(Board::BOAT_PRESENT)
      expect(board.grid[0][1]).to eq(Board::BOAT_PRESENT)
      expect(board.grid[0][2]).to eq(Board::NO_BOAT)
    end

    it "should set on the grid the boat placement vertically" do
      boat = Boat.new(2)
      boats = [boat]
      board = Board.new
      board.boats = boats

      board.place_boat(boat, 0, 0, orientation: :vertical)

      expect(board.grid[0][0]).to eq(Board::BOAT_PRESENT)
      expect(board.grid[1][0]).to eq(Board::BOAT_PRESENT)
      expect(board.grid[2][0]).to eq(Board::NO_BOAT)
    end
  end

  describe "private methods" do
    it "should check the placement bounds and return true for a 2 sized boat placed on 0x0" do
      expect( board.send(:check_placement_bounds, 2, 0, 0, :horizontal)).to eq(true)
    end

    it "should check the placement bounds and return true for a 6 sized boat placed on 0x0" do
      expect( board.send(:check_placement_bounds, 6, 0, 0, :horizontal)).to eq(true)
    end

    it "should check the placement bounds and return false for a 7 sized boat placed on 0x0" do
      expect( board.send(:check_placement_bounds, 7, 0, 0, :horizontal)).to eq(false)
    end

    it "should return false because the boat to be placed overlaps completely the other boat" do
      # horizontal boat
      board.grid[0][0] = board.grid[0][1] = Board::BOAT_PRESENT
      # vertical boat
      board.grid[3][5] = board.grid[4][5] = Board::BOAT_PRESENT

      expect( board.send(:check_free_space, 2, 0, 0, :horizontal)).to eq(false)
      expect( board.send(:check_free_space, 2, 3, 5, :vertical)).to eq(false)
    end

    it "should return false because the boat overlaps another boat" do
      # horizontal boat
      board.grid[0][2] = board.grid[0][3] = Board::BOAT_PRESENT
      # vertical boat
      board.grid[4][5] = board.grid[5][5] = Board::BOAT_PRESENT

      expect( board.send(:check_free_space, 3, 0, 0, :horizontal)).to eq(false)
      expect( board.send(:check_free_space, 3, 2, 5, :vertical)).to eq(false)
    end

    it "should return true because the boats do not overlap" do
      # horizontal boat
      board.grid[0][0] = board.grid[0][1] = Board::BOAT_PRESENT
      # vertical boat
      board.grid[4][5] = board.grid[5][5] = Board::BOAT_PRESENT

      expect( board.send(:check_free_space, 3, 0, 2, :horizontal)).to eq(true)
      expect( board.send(:check_free_space, 3, 1, 5, :horizontal)).to eq(true)
    end
  end
end