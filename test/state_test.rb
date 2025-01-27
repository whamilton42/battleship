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

  def test_state_finds_squares_next_to_hits
    # Given a state with a couple of hits..
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

    # ..this method should fit all the surrounding :unknown squares.
    assert_equal [[2,4],[2,5],[3,3],[3,6],[4,4],[4,5]].sort, state.unknown_squares_next_to_a_hit.sort
  end
  
  def test_state_finds_squares_next_to_greatest_number_of_hits
    # Given one spot with some isolated hits, and another with a juicy middle target..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :hit,     :unknown, :hit,     :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)

    # ..this method should go for the juicy middle.
    assert_equal [[6,7]], state.unknown_squares_next_to_a_hit
  end
  
  def test_state_finds_squares_next_to_greatest_number_of_hits_when_there_are_two_juicy_choices
    # Given one spot with some isolated hits, and another with a juicy middle target, and another even juicier spot..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :hit,     :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :hit,     :unknown, :hit,     :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)

    # ..this method should go for the most juicy.
    assert_equal [[1,3]], state.unknown_squares_next_to_a_hit
  end
  
  def test_squares_on_the_end_of_longest_hit_streak_for_column
    # Given one spot with an isolated hit, and another with two in a row..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :hit,     :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :miss,    :miss,    :miss,    :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)

    # ..this method should go for a square by the two-hits-in-a-row.
    assert_equal [[3,3],[3,6]], state.squares_on_the_end_of_longest_hit_streak
  end
  
  def test_squares_on_the_end_of_longest_hit_streak_for_row
    # Given one spot with an isolated hit, and another with two in a row..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :hit,     :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :hit,     :hit,     :hit,     :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)

    # ..this method should go a square by the three-hits-in-a-row.
    assert_equal [[2,5],[6,5]], state.squares_on_the_end_of_longest_hit_streak
  end
  
  def test_squares_on_the_end_of_longest_hit_streak_copes_with_solitary_hit
    # Given one spot with an isolated hit, and another with two in a row..
    raw_state = []
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :hit,     :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    raw_state << [:unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown, :unknown]
    
    state = State.new(raw_state)

    # ..this method should go for one of the squares surrounding the solitary hit.  
    assert_equal [[3,5],[4,4],[4,6],[5,5]].sort, state.squares_on_the_end_of_longest_hit_streak.sort
  end
end