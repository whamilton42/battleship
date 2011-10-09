require "minitest/autorun"
require "battleship/game"
require "mocha"

load File.expand_path("players/bishop_player.rb")

class ShipTest < MiniTest::Unit::TestCase

  def test_ship_next_to_other_ship_method
    # xxxxxxxxxx
    # xooooxxxxx
    # xoooooxxxx
    ship = Ship.new([1,1,4,:across])
    other_ship = Ship.new([1,2,5,:across])
    
    assert ship.next_to_other_ship?(other_ship)
    
    
    # But if the other_ship is miles away..
    other_ship = Ship.new([1,6,5,:across])
    
    assert_equal false, ship.next_to_other_ship?(other_ship)
    
    # xxxxxxxxxx
    # xxxxxxxxxx
    # xxxxooxxxx
    # xxxxxoxxxx
    # xxxxxoxxxx
    ship = Ship.new([4,3,2,:across])
    other_ship = Ship.new([5,4,2,:down])
    
    assert ship.next_to_other_ship?(other_ship)
  end

  def test_ship_squares_method
    assert_equal [[0,0],[0,1],[0,2],[0,3],[0,4]], Ship.new([0,0,5,:down]).squares
    assert_equal [[4,5],[5,5],[6,5]], Ship.new([4,5,3,:across]).squares
  end
end