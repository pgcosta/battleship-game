require_relative '../boat'

describe Boat do

  let(:boat) { Boat.new(3) }

  it "should initialize a boat with correct health, size" do
    expect(boat.size).to eq(3)
    expect(boat.health).to eq(3)
  end

  it "should decrease health by one after a hit" do
    boat.take_hit

    expect(boat.health).to eq(2)

    boat.take_hit
    expect(boat.health).to eq(1)
  end

  it "should decrease health by one after a hit" do
    boat.take_hit

    expect(boat.health).to eq(2)

    boat.take_hit
    expect(boat.health).to eq(1)
  end

  it "should return available health after a hit" do
    expect(boat.take_hit).to eq(2)

    expect(boat.take_hit).to eq(1)
  end

  describe "private methods" do
    describe "shot_missed?" do
      it "should return true if the shot was a miss(horizontal)" do
        # make boat will be on (0,0) (0,1)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :horizontal

        expect(boat.send(:shot_missed?,0,2)).to be true
      end

      it "should return true if the shot was a miss(vertical)" do
        # make boat will be on (0,0) (1,0)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :vertical

        expect(boat.send(:shot_missed?,2,0)).to be true
      end

      it "should return false if the shot was a hit(horizontal)" do
        # make boat will be on (0,0) (0,1)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :horizontal

        expect(boat.send(:shot_missed?,0,1)).to be false
      end

      it "should return false if the shot was a miss(vertical)" do
        # make boat will be on (0,0) (1,0)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :vertical

        expect(boat.send(:shot_missed?,1,0)).to be false
      end
    end

    describe "possible_hit?" do
      it "should return false if it is impossible for the boat to be in the shot coordinates(horizontal)" do
        # make boat will be on (0,0) (0,1)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :horizontal

        expect(boat.send(:possible_hit?, 1, 0)).to be false
      end

      it "should return false if it is impossible for the boat to be in the shot coordinates(vertical)" do
        # make boat will be on (0,0) (1,0)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :vertical

        expect(boat.send(:possible_hit?, 0, 1)).to be false
      end

      it "should return true if it is possible for the boat to be in the shot coordinates(horizontal)" do
        # make boat will be on (0,0) (0,1)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :horizontal

        expect(boat.send(:possible_hit?, 0, 1)).to be true
      end

      it "should return true if it is possible for the boat to be in the shot coordinates(vertical)" do
        # make boat will be on (0,0) (1,0)
        boat.row = 0
        boat.column = 0
        boat.size = 2
        boat.orientation = :vertical

        expect(boat.send(:possible_hit?, 1, 0)).to be true
      end
    end
  end
end