class Game
    def initialize
      @deck = Deck.new
      @players = []
      @pot = 0
      @current_player_index = 0
    end
# ^ sets up the initial state of the game including creating a new deck, initializing an empty array of players, setting the pot to 0, and
# setting the index of the current player to 0.
  
    def play_round
      deal_cards_to_players
      conduct_betting_round
      handle_discard_and_replace
      conduct_betting_round
      determine_winner
    end
# this method creates all the things involved in playing a game of poker
    private
  
    def deal_cards_to_players
      @players.each { |player| player.hand = Hand.new(Array.new(5) { @deck.deal }) }
    end
  # this is dealing out the 5 cards to the players
  def conduct_betting_round
    @players.each do |player|
      handle_action(player, player.decide_action(current_bet))
    end
  end  
  # This is where the betting round begins. It iterates through each player, and for each player there is a 'decide action'
  #on the object which is the player. It then passes the 'current bet". all of this is then handled by the 'handle_action"
    def handle_action(player, action)
      case action
      when :fold then @players.delete(player)
      when :see then handle_see(player)
      when :raise then handle_raise(player)
      end
    end
  # based on what the bettring round determined it is then passed into the many cases held here
    def handle_see(player)
      amount = current_bet
      player.pot -= amount
      @pot += amount
    end
  # this takes the player object and calculates the amount needed to match the currect bet. 
  #It does this by calling the current_bet method. Takes the money from the player and adds it to the pot
  def handle_raise(player)
    raise_amount = player.decide_raise_amount
    total_bet = current_bet + raise_amount
  
    player.pot -= total_bet
    @pot += total_bet
    update_current_bet(total_bet)
  end
  
  # this determines the amount the player wants to raise. The raise amount is calculated first, then 
  # the total bet is calculated by adding the current bet to the raised amount. Players pot is then reduced and the 
  # pot is increased. Then the update_current_bet updates the current bet. 
    def handle_discard_and_replace
      @players.each do |player|
        cards_to_discard = player.discard
        cards_to_discard.each { |_| player.hand.cards.delete_at(rand(player.hand.cards.length)) }
        cards_to_discard.length.times { player.hand.cards << @deck.deal }
      end
    end
  # ^ this iterates through each player and for each player it calls on the discard method to get rid of them and they
  # go into cards_to_discard. It then iterates through cards_to_discard and removes each card from the players by using
  # delete_at. Then it deals new cards to te players hand based on the number of cards discarded. It does this randomly and calls 
  # on deck.deal within a loop, that runs for the length of cards_to_discard
    def determine_winner
      winning_player = @players.max_by { |player| player.hand.determine_hand_strength }
      winning_player.pot += @pot
      @pot = 0
    end
  # this method finds the strongest hand among all players using max_by. This iterates through each player and evaluates their hand stength
  # using player.hand.determine_hand_strength. It then takes the total pot and gives it to the player and resets the pot to 0.
    def current_bet
        @players.map(&:current_bet).max || 0
    end
  #this method retrieves the current bet from all players usin map to create an arraya of bet amounts. Finds the maximum bet amount 
  # using max and can also return 0 if there are no bets placed. 
    def update_current_bet(new_bet)
        @current_bet = new_bet
    end
  end
  # this method takes a new bet amount as a paramater. It then assigns to it current bet, which updates the current highest bet to the new value. 
  
  