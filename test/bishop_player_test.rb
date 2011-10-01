require "minitest/autorun"
require "battleship/game"
require "mocha"

load File.expand_path("players/bishop_player.rb")
load File.expand_path("players/human_player.rb")

class BishopPlayerTest < MiniTest::Unit::TestCase
  
  def test_starting_positions_are_valid
    # Given a new game..
    ::HumanPlayer
    bishop = ::BishopPlayer.new
    starting_positions = bishop.new_game
    
    # ..it should match the requirements.
    assert_equal 5, starting_positions.length
    starting_positions.each do |ship|
      assert ship.is_a? Array
      assert_equal 4, ship.length # x, y, length, orientation
      
      assert ship[0].is_a? Fixnum # x
      assert ship[1].is_a? Fixnum # y
      assert ship[2].is_a? Fixnum # length
      assert ship[3].is_a? Symbol # orientation
      
      assert (0..9).include? ship[0]
      assert (0..9).include? ship[1]
      assert (2..5).include? ship[2]
      assert [:across, :down].include? ship[3]
    end
  end
  
  def test_starting_position_contains_no_perimter_ships    
    # Given a new game..
    bishop = ::BishopPlayer.new
    starting_positions = bishop.new_game
    
    # ..none of the positions should be on the edge.
    # i.e., no 0s or 9s.
    starting_positions.each do |ship|
      assert_equal false, [0,9].include?(ship[0])
      assert_equal false, [0,9].include?(ship[1])
    end
  end
  
end