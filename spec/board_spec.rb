require_relative '../board'

describe Board do
  it "should initialize a new grid" do
    board = Board.new

    expect(board.grid.class).to eq(Array)
  end

  it "should initialize a new grid with height of 6" do
    board = Board.new

    # height must be 6
    expect(board.grid.size).to eq(6)
  end

  it "should initialize a new grid with width of 6" do
    board = Board.new

    expect(board.grid[1].size).to eq(6)
  end

  # the boundaries are 6x6
  it "should initialize a new grid within the boundaries" do
    board = Board.new

    expect(board.grid[5][5]).to eq(nil)
    # [7][7] should not exist, and throw an error
    expect {
      board.grid[6][6]
    }.to raise_error
  end
end