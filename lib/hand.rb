class Hand
    attr_reader :cards
  
    def initialize(cards)
      @cards = cards
    end
    # ^This part defines the Hand class and its initialize method. 
    #The initialize method takes an array of cards as an argument and assigns it to an instance variable @cards. 
    #This array represents the cards in the hand.
  
    def hand_strength
      value_counts = Hash.new(0)
      @cards.each { |card| value_counts[card.value] += 1 } #this line of code iterates over each card in the @cards array, counts the occurrences of each card value, and stores the counts in a hash called value_counts. This is essential for determining the strength of the hand.
  
      case value_counts.values.max
      when 4 then :four_of_a_kind
      when 3
        value_counts.values.count(2) == 1 ? :full_house : :three_of_a_kind
      when 2
        value_counts.values.count(2) == 2 ? :two_pair : :pair
      else
        :high_card
      end
    end
    # ^ The determine_hand_strength method calculates the strength of the hand based on the values of the cards. 
    #It counts the occurrences of each card value using a hash called value_counts. Then, it uses a case statement 
    #to check for specific combinations and returns a symbol representing the hand strength.
  
    def beats?(other_hand)
      my_strength = hand_strength
      other_strength = other_hand.hand_strength
  
      if my_strength == other_strength
        @cards.map(&:value).max > other_hand.cards.map(&:value).max
      else
        HAND_STRENGTHS.index(my_strength) > HAND_STRENGTHS.index(other_strength)
      end
    end
  # The beats? method compares the strength of the current hand with another hand (other_hand). 
  #It first determines the strengths of both hands using hand_strength and then compares them.
  #If the strengths are equal, it compares the highest card value to determine the winner.
  #If the strengths are different, it compares their positions in the HAND_STRENGTHS array to determine the winner.
    private
  
    HAND_STRENGTHS = [:high_card, :pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush, :royal_flush].freeze
  end
  