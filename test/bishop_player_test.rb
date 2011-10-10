require "minitest/autorun"
require "battleship/game"
require "mocha"

load File.expand_path("players/bishop_player.rb")
load File.expand_path("players/human_player.rb")

class BishopPlayerTest < MiniTest::Unit::TestCase
  
  def test_starting_positions_are_valid
    # Given a new game..
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
  
  def test_starting_position_contains_no_adjacent_ships
    # skip "Need to write the model code to test against this"
    # Given a new game..
    bishop = ::BishopPlayer.new
    starting_positions = bishop.new_game
    
    # ..none of the positions should be next to one another.
    starting_positions.each do |ship|
      starting_positions.each do |other_ship|
        next if ship == other_ship
        assert !Ship.new(ship).next_to_other_ship?(Ship.new(other_ship))
      end
    end
  end
  
  def test_next_turn_goes_for_horizontal_gap
    state = []
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :miss,    :miss]
    
    player = BishopPlayer.new
    new_shot_coords = player.take_turn(state, [2])
    
    assert [[3, 9],[4,9]].include? new_shot_coords
  end
  
  def test_next_turn_goes_for_vertical_gap
    # If we have a board, with one gap of three, but laods of gaps of two..
    state = []
    state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    
    # ..then if only the length-3 ship is left..
    player = BishopPlayer.new
    new_shot_coords = player.take_turn(state, [3])
    
    # ..the player should hit that gap.
    assert [[1,4],[1,5],[1,6]].include? new_shot_coords
  end
  
  def test_next_turn_limits_space_for_largest_ship
    # If we have a board, with two overlapping gaps of four..
    state = []
    state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :miss,    :unknown, :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :unknown, :unknown, :unknown, :unknown, :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss]

    # ..then if the 4-length ship is left..
    player = BishopPlayer.new
    new_shot_coords = player.take_turn(state, [4,3,3,2])

    # ..the player should go for the square that limits the spaces it can be.
    assert_equal [3,6], new_shot_coords
  end
  
  def test_starting_position_contains_no_perimter_ships
    skip "Not sure if we want this at all.."
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