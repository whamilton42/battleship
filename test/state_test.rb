require "minitest/autorun"
require "battleship/game"
require "mocha"

load File.expand_path("players/bishop_player.rb")

class StateTest < MiniTest::Unit::TestCase

  def test_gaps_method_finds_single_gap
    # With one gap of 3 here..
    raw_state = []
    raw_state << [:miss,    :miss,    :unknown, :unknown, :unknown, :miss,    :miss,    :miss,    :unknown, :unknown]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :hit]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :hit]
 
    state = State.new(raw_state)
    
    # ..the State should find the gap.
    assert_equal [[2,0],[3,0],[4,0]], state.squares_in_gap_of_length(3)
  end
  
  def test_gaps_method_finds_two_gaps_on_same_line
   # With two gaps of 3 here..
    raw_state = []
    raw_state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :unknown, :unknown]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :hit]
    raw_state << [:miss,    :unknown, :unknown, :unknown, :miss,    :miss,    :unknown, :unknown, :unknown, :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :hit,     :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :hit]

    state = State.new(raw_state)

    # ..the State should find the gap.
    assert_equal [[1,4],[2,4],[3,4],[6,4],[7,4],[8,4]], state.squares_in_gap_of_length(3)
  end
  
  
  def test_gaps_method_includes_overflow_squares
    # With two gaps of 3 here..
    raw_state = []
    raw_state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :unknown, :unknown]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :hit]
    raw_state << [:miss,    :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :miss,    :unknown, :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :hit,     :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :hit]

    state = State.new(raw_state)

    # ..the State should find the gap, plus the extra squares to the right.
    assert_equal [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4]], state.squares_in_gap_of_length(3)
  end
  
  def test_columns
    raw_state = []
    raw_state << [:miss,    :miss,    :miss,    :unknown, :unknown, :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :hit]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :hit,     :miss,    :miss,    :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :hit,     :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :hit]
 
    state = State.new(raw_state)
    
    assert_equal [:miss,:miss,:miss,:miss,:unknown,:unknown,:unknown,:miss,:miss,:miss], state.columns[1]
    assert_equal [:miss,:miss,:miss,:unknown,:unknown,:hit,:hit,:miss,:miss,:miss], state.columns[6]
    assert_equal [:miss,:miss,:miss,:hit,:miss,:miss,:miss,:miss,:miss,:hit], state.columns[9]
  end
  
  def test_gaps_method_does_not_get_confused_with_hits
    # With two gaps of 3 here..
    raw_state = []
    raw_state << [:miss,    :miss,    :unknown, :hit,     :unknown, :miss,    :miss,    :miss,    :unknown, :unknown]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :hit]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss]
    raw_state << [:miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :hit,     :miss,    :miss,    :miss,    :miss,    :hit,     :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :unknown, :unknown, :miss]
    raw_state << [:miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss,    :miss]
    raw_state << [:miss,    :miss,    :miss,    :unknown, :miss,    :miss,    :miss,    :miss,    :miss,    :hit]
 
    state = State.new(raw_state)
    
    # ..the State should find the gap.
    assert_equal [[2,0],[4,0],[1,4],[1,5]], state.squares_in_gap_of_length(3)
  end
  
  def test_gaps_method_can_finish_off_stupid_player
    raw_state = []
    raw_state << [:hit,     :hit,     :hit,     :unknown, :unknown, :miss,    :unknown, :unknown,  :unknown, :unknown]
    raw_state << [:hit,     :hit,     :hit,     :unknown, :unknown, :unknown, :miss,    :unknown,  :unknown, :unknown]
    raw_state << [:hit,     :hit,     :hit,     :unknown, :unknown, :unknown, :unknown, :miss,     :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :miss,    :unknown, :unknown, :unknown, :unknown,  :miss,    :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :miss,    :unknown, :unknown, :unknown,  :unknown, :miss]
    raw_state << [:miss,    :unknown, :unknown, :unknown, :unknown, :miss,    :unknown, :unknown,  :unknown, :unknown]
    raw_state << [:unknown, :miss,    :unknown, :unknown, :unknown, :unknown, :miss,    :unknown,  :unknown, :unknown]
    raw_state << [:unknown, :unknown, :miss,    :unknown, :unknown, :unknown, :unknown, :miss,     :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :miss,    :unknown, :unknown, :unknown, :unknown,  :miss,    :miss]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :miss,    :miss,    :miss,    :miss,     :miss,    :miss]
    state = State.new(raw_state)

    # ..the State should find some squares.
    assert state.squares_in_gap_of_length(5).any?
  end

  def test_next_part_of_ship
    # Given a state with two hits, and the 3-length ship still left..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)
    square = state.next_part_of_ship([3,5])
    # puts "#{square[0]}, #{square[1]}"
    
    assert [[2,4],[2,5],[3,3],[3,6],[4,4],[4,5]].include? square
    assert [[2,4],[2,5],[3,3],[3,6],[4,4],[4,5]].include? state.next_part_of_ship([3,5])
    # assert [[3,3],[3,6]].include? state.next_part_of_ship([3,4])
    # assert [[3,3],[3,6]].include? state.next_part_of_ship([3,5])
  end
end