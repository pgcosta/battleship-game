require_relative '../boat'

describe Boat do
  it "should initialize a boat with correct health, size" do
    boat = Boat.new(3)

    expect(boat.size).to eq(3)
    expect(boat.health).to eq(3)
  end

  it "should decrease health by one after a hit" do
    boat = Boat.new(3)
    boat.take_hit

    expect(boat.health).to eq(2)

    boat.take_hit
    expect(boat.health).to eq(1)
  end

  it "should decrease health by one after a hit" do
    boat = Boat.new(3)
    boat.take_hit

    expect(boat.health).to eq(2)

    boat.take_hit
    expect(boat.health).to eq(1)
  end

  it "should return available health after a hit" do
    boat = Boat.new(3)

    expect(boat.take_hit).to eq(2)

    expect(boat.take_hit).to eq(1)
  end
end