class NearlyStupidPlayer
  
  attr_reader :previous_shots
  
  def name
    "Nearly Stupid Player"
  end

  def new_game
    [
      [0, 0, 5, :across],
      [0, 1, 4, :across],
      [0, 2, 3, :across],
      [0, 3, 3, :across],
      [0, 4, 2, :across]
    ]
  end

  def take_turn(state, ships_remaining)
    @previous_shots ||= []
    
    shot = [rand(10), rand(10)]
    while(@previous_shots.include? shot)
      shot = [rand(10), rand(10)]
    end
    @previous_shots << shot
    return shot
  end
end
