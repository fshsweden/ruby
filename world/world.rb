# -------------------------------------------------------
#
#
#
# -------------------------------------------------------

require_relative 'player'

class World

  def initialize ()
    puts "Initializing World!"
    #@position = Hash.new 
    @players = Hash.new
  end 

  def get_player(name)
    @players[name] ||= add_player(name) 
  end 

  def add_player(name) 
    if @players.key?(name)
      false
    else
      @players[name] = Player.new(name)
    end
  end

  def get_players
    @players.keys
  end

  def get_players_pos(name)
    player = get_player(name)
    return player.get_position
  end

end

