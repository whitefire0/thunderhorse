class Tile
  attr_accessor :tile_type, :tile_description, :enemy_present, :enemy, :item_present, :item

  def initialize
    roll_tile_type
    select_tile_description
    pick_enemy if roll_enemy_chance
    pick_item if roll_item_chance
  end

  def roll_tile_type
    @tile_type = [
      'hot', 'cold', 'freezing',
      'grassy', 'damp', 'misty',
      'demonic', 'quantum', 'dungeon', 
      'dungeon', 'dungeon', 'dungeon', 
      'dungeon', 
    ].sample
  end

  def roll_item_type
    @item_type = [
      'health potion', 'strength potion', 'constituition potion',
      'intelligence potion', 'dexterity potion', 'potion of luck',
      'the blood of christ', 'scroll of spectral swords',
      'potion of premature dementia', 'a marble of dark matter',
      'holy bomb', 'scroll of gimp', 'scroll of lightning', 
      'unidentified potion', 'scroll of teleport', 'you dont know javascript', 'invincibility potion'
    ].sample
  end

  def select_tile_description
    case @tile_type
    when 'hot'
      @tile_description = "You have entered a particularly hot area. Your instincts tell you a Balrog was wandering here recently."
    when 'cold'
      @tile_description = "As you exhale, the air condenses into a distinct stream of vapour. Do Wreaths make places cold? You search for your baddy codex and realise you left it at home next to your WTF ARE YOU DOING?"
    when 'freezing'
      @tile_description = "You tighten your robes, this area is at least -20C. In a flash of horror you remember that Wreathes are well known for leaving trails of cold death behind them."
    when 'grassy'
      @tile_description = "You're not sure how, as this place is underground, but you emergy into a grassy bank. You decide to let it go for now."
    when 'damp'
      @tile_description = "This place just smells a bit. Of wet dog, weirdly."
    when 'misty'
      @tile_description = "Stumbling over a rock, a thick fog reduces how much you can see. For a minute, you feel comforted, safe even. It then dawns quite rapidly in your mind that you are only able to see a foot in front of you. You could swear you heard a rattling of chains, too."
    when 'demonic'
      @tile_description = "You find yourself arrested by terrible visions of demons and ghoulies. No doubt about it, this place is demonic as hell. The pentagrams and blood on the walls are a bit of a giveaway."
    when 'quantum'
      @tile_description = "Your belly gurgles and it is slower than usual...when you move your eyes, little pixels of light form in the corner of your eyes. In the distance you hear a cat, and you have a sudden sense that reality is thin here. You don't know what this means but you are not feeling good about it."
    else
      @tile_description = "There is nothing remarkable about this place..."
    end
  end

  def roll_enemy_chance
    @enemy_present = generate_1_in_5
    # *** FOR TESTING ONLY ***
    # true
  end

  def roll_item_chance
    # @item_present = generate_1_in_5
    # *** FOR TESTING ONLY ***
    true
  end

  def pick_item
    @item = Item.new
  end

  def pick_enemy
    # @enemy = Balrog.create('Arse Itch')
    enemy_choice_probability = rand(100)
    p = enemy_choice_probability
    case
    when p < 60 
      @enemy = SewerRat.create('Ratlet')
    when p >= 60 && p <= 80
      @enemy = Goblin.create('Arse Itch')
    when p > 80 && p <= 90
      @enemy = Wreath.create('Nazgul')
    when p > 90 && p <= 100
      @enemy = Balrog.create('Beatrice')
    else
    end
    @enemy_present = true
  end

  def generate_1_in_5
    [true, false, false, false, false].sample
  end
end