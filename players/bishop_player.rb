class BishopPlayer
  
  attr_accessor :last_state, :last_ships_remaining, :last_shot
  
  def name
    "Bishop Player"
  end

  def new_game
    # not at the perimeter
    # not together
    # same orientation?
    ships = [Ship.new_random(2), Ship.new_random(3), Ship.new_random(3), Ship.new_random(4), Ship.new_random(5)]
    while(ships.detect { |ship| ship.next_to_any_of_these_ships?(ships) })
      ships = [Ship.new_random(2), Ship.new_random(3), Ship.new_random(3), Ship.new_random(4), Ship.new_random(5)]
    end
    
    return ships.map(&:to_standard_format)
  end


  def take_turn(raw_state, ships_remaining)
    state = State.new(raw_state)
    
    just_made_a_hit = (last_state and raw_state.flatten.select{|square| square == :hit}.length > last_state.flatten.select{|square| square == :hit}.length)
    
    just_destroyed_a_ship = (last_ships_remaining and ships_remaining.length < last_ships_remaining.length)
    
    if just_made_a_hit and !just_destroyed_a_ship
      # last_shot
      
      # raise "did both"
      puts "did both"
    end
    
    
    
    # close off areas
    # don't bother looking in areas smaller than the smallest ship left
    # that's it
    
    # try every move and go for it if it lowers the number of areas
    # the largest ship left can hide in
    
    squares = state.squares_in_gap_of_length(ships_remaining.sort.last)
    
    raise "No squares!" if squares.empty?
    
    least_squares = squares.length
    # puts squares.length
    best_shots = []
    squares.each do |shot|
      new_raw_state = Marshal.load(Marshal.dump(raw_state)) # deep clone
      new_raw_state[shot[1]][shot[0]] = :miss
      new_state = State.new(new_raw_state)
      new_squares = new_state.squares_in_gap_of_length(ships_remaining.sort.last)
      
      # raise "No squares!" if new_squares.empty?
      # puts "Shooting at #{shot[0]},#{shot[1]} leaves #{new_state.squares_in_gap_of_length(ships_remaining.sort.last).length} squares."
      if new_squares.length <= least_squares
        least_squares = new_squares.length
        if new_squares.length < least_squares
          best_shots << shot
        else
          best_shots = [shot]
        end
      end
    end
    
    shot = best_shots.shuffle.first
    
    @last_state = raw_state
    @last_ships_remaining = ships_remaining
    @last_shot = shot
    
    return shot
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


class State
  attr_reader :raw_state
  def initialize(raw_state)
    @raw_state = raw_state
  end
  
  def rows
    return @raw_state
  end
  
  def columns
    columns = []
    10.times do |col_num|
      column = []
      10.times do |row_num|
        next unless @raw_state[row_num]
        column << @raw_state[row_num][col_num]
      end
      columns << column unless column.empty?
    end
    return columns
  end
  
  def squares_with_results
    squares = []
    10.times do |row_num|
      row = @raw_state[row_num]
      next unless row
      
      10.times do |col_num|
        squares << { :coords => [row_num, col_num], :result => row[col_num] }
      end
    end
    return squares
  end
  
  def squares_in_gap_of_length(length)
    squares = []
    
    # Rows
    @raw_state.length.times do |row_num|
      row = @raw_state[row_num]
      
      first_instances = []
      10.times do |index|
        first_instances << index if (row[index] != :miss and (index == 0 or row[index - 1] == :miss))
      end
      
      first_instances.each do |first_instance|
        if !row[first_instance, length].uniq.include?(:miss) and first_instance + length <= 10
          stop_adding = false
          col_num = first_instance
          
          row[first_instance..-1].each do |square|
            stop_adding = true if square == :miss
            next if stop_adding
            
            squares << [col_num, row_num] unless square == :hit
            col_num += 1
          end 
        end
      end
    end
    
    # Columns
    columns.length.times do |col_num|
      column = columns[col_num]
      
      first_instances = []
      10.times do |index|
        first_instances << index if (column[index] != :miss and (index == 0 or column[index - 1] == :miss))
      end
      
      first_instances.each do |first_instance|
        if !column[first_instance, length].uniq.include?(:miss) and first_instance + length <= columns.length
          stop_adding = false
          row_num = first_instance
          
          column[first_instance..-1].each do |square|
            stop_adding = true if square == :miss
            next if stop_adding
            
            squares << [col_num, row_num] unless square == :hit
            row_num += 1
          end 
        end
      end
    end
    
    return squares.uniq
  end
  
  def next_part_of_ship(square)
    
    # Below
     if raw_state[square[1]+1][square[0]] == :hit
       10.times do |increment|
         next if increment == 0
         next if square[0] + increment > 9
         # puts [square[0] + increment, square[1]]
         raise "below"
         return [square[0] + increment, square[1]]  if raw_state[square[0] + increment][square[1]] == :unknown
       end
     end
     
     
    # Above
    if raw_state[square[1]-1][square[0]] == :hit
      10.times do |increment|
        next if increment == 0
        next if square[0] - increment > 9
        # raise "above"
        # puts [square[0] - increment, square[1]]
        return [square[0] - increment, square[1]]  if raw_state[square[0] - increment][square[1]] == :unknown
      end
    end
    
 
    # state.rows
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