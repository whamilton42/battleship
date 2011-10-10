class DecentPlayer
  
  attr_reader :previous_shots
  
  def name
    "Decent Player"
  end

  def new_game
    # not together
    ships = [Ship.new_random(2), Ship.new_random(3), Ship.new_random(3), Ship.new_random(4), Ship.new_random(5)]
    while(ships.detect { |ship| ship.next_to_any_of_these_ships?(ships) })
      ships = [Ship.new_random(2), Ship.new_random(3), Ship.new_random(3), Ship.new_random(4), Ship.new_random(5)]
    end
    
    return ships.map(&:to_standard_format)
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


class Ship
  attr_accessor :x, :y, :length, :orientation
  def initialize(array)
    @x = array[0]
    @y = array[1]
    @length = array[2]
    @orientation = array[3]
  end
  
  def valid?
    return false unless (2..5).include? @length
    return false unless [:across, :down].include? @orientation
    self.squares.each do |square|
      return false unless (0..9).include? square[0]
      return false unless (0..9).include? square[1]
    end
    return true
  end
  
  def self.new_random(length)
    ship = self.new([0,0,0,:across])
    
    while !ship.valid?
      ship.x = rand(10)
      ship.y = rand(10)
      ship.length = length
      ship.orientation = [:across, :down][rand(2)]
    end
    
    return ship
  end
  
  def to_standard_format
    [@x, @y, @length, @orientation]
  end
  
  def next_to_any_of_these_ships?(other_ships)
    other_ships.each do |other_ship|
      next if self == other_ship
      return true if self.next_to_other_ship?(other_ship)
    end
    return false
  end
  
  def next_to_other_ship?(other_ship)
    raise "Comparing self with self - of course it's next to it!" if self == other_ship
    self.squares.each do |square|
      other_ship.squares.each do |other_square|
        return true if (square[0] == other_square[0] and (square[1] - other_square[1]).abs <= 1)
        return true if (square[1] == other_square[1] and (square[0] - other_square[0]).abs <= 1)
      end
    end
    return false
  end
  
  def squares
    squares = []
    case @orientation
    when :down
      @length.times do |extension|
        squares << [@x, @y + extension]
      end
    when :across
      @length.times do |extension|
        squares << [@x + extension, @y]
      end  
    end
    return squares
  end
end