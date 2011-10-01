class BishopPlayer
  def name
    "Bishop Player"
  end

  def new_game
    # not at the perimeter
    # not together
    # same orientation?
    
    [
      [0, 0, 5, :across],
      [0, 1, 4, :across],
      [0, 2, 3, :across],
      [0, 3, 3, :across],
      [0, 4, 2, :across]
    ]
  end

  def take_turn(state, ships_remaining)
    # close off areas
    # don't bother looking in areas smaller than the smallest ship left
    
    puts "ships remaining: #{ships_remaining.inspect}"
    puts "co-ordinates (x,y)?"
    x, y = $stdin.gets.split(",").map{ |a| a.strip.to_i }
  end
  
  
  private
  
  def opponent_type
    # How is the opponent playing?
    # Since they're a computer, they should have set programmes.
    # :permieter, :corner, :same_orientation
  end
  
  def board_areas(state)
    
  end
  
end