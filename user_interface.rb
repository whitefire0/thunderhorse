# UserInterface will eventually shield the entire inner application, exposing only accepted commands
class UserInterface
  def initialize(game)
    @game_instance = game
    @player_created = false
    @character_chosen = false
    @chosen_action = nil
    @play_again = nil
  end
  
  def run_menu
    while @game_instance.on do
      create_player unless @player_created
      @game_instance.select_character_instance unless @character_chosen
      @game_instance.on = true if @player_created && @character_chosen

      @game_instance.get_new_tile
      present_tile
      get_player_action

      # binding.pry
      case @chosen_action
      when "attack"
        if @game_instance.current_tile.enemy
          @game_instance.battle_mode
          exit_game? if @game_instance.player_char.is_dead
        else
          puts "You are attacking thin air...there is no enemy. Conserve your energy you dimwit."
        end
      when "rest"
        # code
      when "inspect"
        # code
      when "hide"
        # code
      else
      end

      # return true/false to outer game creation loop in main.rb
      if @play_again
        return true
      else
        return false
      end
    end
  end

  def create_player
    unless @player_created
      # puts "Please enter your name, player: \n"
      # @game_instance.player_name = gets.chomp
      # *** FOR TESTING ***
      @game_instance.player_name = 'Rick'
      @player_created = true
    end
  end

  def welcome_player
    puts "Welcome to the dungeon, #{@game_instance.player_name} the #{@game_instance.player_char.class}! Untold glory awaits you.\n".colorize(:blue)
    # binding.pry
    puts "These are your character stats:\n
        Age: #{@game_instance.player_char.age}
        Health: #{@game_instance.player_char.health}
        Strength: #{@game_instance.player_char.strength}
        Constitution: #{@game_instance.player_char.constitution}
        Intelligence: #{@game_instance.player_char.intelligence}
        Dexterity: #{@game_instance.player_char.dexterity}
        Your unique skill: #{@game_instance.player_char.unique_skills.first}\n".colorize(:blue)
    @character_chosen = true
  end

  def present_tile
    puts "You step forward, into the next dungeon area...".colorize(:light_green)
    puts @game_instance.current_tile.tile_description.colorize(:green)
    if @game_instance.current_tile.enemy_present
      puts "\nAn enemy has appeared! #{@game_instance.current_tile.enemy.name} the #{@game_instance.current_tile.enemy.class} is standing in front of you!\n".colorize(:light_red)
      puts "You take a look closer at the bastard, and see...\n
            Name: #{@game_instance.current_tile.enemy.name}
            Type: #{@game_instance.current_tile.enemy.class}
            Age: #{@game_instance.current_tile.enemy.age}
            Health: #{@game_instance.current_tile.enemy.health}
            Strength: #{@game_instance.current_tile.enemy.strength}
            Constitution: #{@game_instance.current_tile.enemy.constitution}
            Intelligence: #{@game_instance.current_tile.enemy.intelligence}
            Dexterity: #{@game_instance.current_tile.enemy.dexterity}
            Unique Skill: #{@game_instance.current_tile.enemy.unique_skills}\n".colorize(:yellow)
    end
  end

  def get_player_action
    # *** FOR TESTING ***
    @chosen_action = 'attack'
    while @chosen_action == nil
      puts "Player, make your choice:
            a = attack
            r = rest
            i = inspect area
            h = hide\n"
      response = gets.chomp
      case response
      when /^a|A/
        @chosen_action = 'attack'
      when /^r|R/
        @chosen_action = 'rest'
      when /^i|I/
        @chosen_action = 'inspect'
      when /^h|H/
        @chosen_action = 'hide'
      else
        puts "Invalid action. Please choose again.".colorize(:light_black)
      end
    end
  end

  def exit_game?
    @play_again = nil
    while @play_again == nil do
      puts "You have been defeated! Would you like to play again? (y/n)"
      response = gets.chomp
      case response
      when /^y|Y/
        @play_again = true
      when /^n|N/
        @play_again = false
      else
        puts "Invalid answer. Please choose again.".colorize(:light_black)
      end
    end

    @game_instance.on = false if @play_again == false

    # binding.pry
    # if @play_again
    #   @player_created = false
    #   @character_chosen = false
    #   @chosen_action = nil
    # else
    #   @game_instance.on = false
    # end
  end
end