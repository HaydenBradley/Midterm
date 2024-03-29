class Player
    attr_accessor :hand, :pot
  
    def initialize
      @hand = []
      @pot = 0
    end
  # This initializes the Player class with attributes for the player's hand and pot, setting them to empty and 0.
    def discard
      puts "Which cards do you want to discard? Enter the positions ex: ( 1 3 4) separated by spaces, or type 'none' to keep all cards:"
      input = gets.chomp.downcase
  
      return if input == 'none'
  
      positions_to_discard = input.split.map(&:to_i)
      @hand.reject!.with_index { |_, index| positions_to_discard.include?(index + 1) }
  
      puts "Discarded #{positions_to_discard.length} card(s)."
    end
   # In the discard method, the player is prompted to choose cards to discard, and those cards are removed from the hand if specified by the player.
   def decide_action_prompt
    "Enter what you want to do: fold, see (to match the current bet), or raise followed by the amount ex: (raise 10):"
  end
  
  def decide_action(current_bet)
  loop do
    puts decide_action_prompt
    action = gets.chomp.downcase.split
    case action[0]
    when 'fold' then return :fold
    when 'see' then return :see if @pot >= current_bet
    when 'raise'
      raise_amount = action[1].to_i
      return :raise, raise_amount if raise_amount.positive? && @pot >= current_bet + raise_amount
    end
    puts "Invalid or not enough money"
  end
end

  
  
    end
  