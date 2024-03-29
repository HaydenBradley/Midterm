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
          my_sorted_values = @cards.map(&:value).sort.reverse
          other_sorted_values = other_hand.cards.map(&:value).sort.reverse
          
          my_sorted_values.each_with_index do |value, index|
            return true if value != other_sorted_values[index]
          end
          # If all card values are equal, it's a tie, so return false
          false
        else
          HAND_STRENGTHS.index(my_strength) > HAND_STRENGTHS.index(other_strength)
        end
      end
      # I had to update this method. It now iterates through the card values and compares each pair.
      # If there is a difference, it returns true, if the current hands value is higher, it indicates a win. It will 
      # go through the comparisons until it cannot find a difference and the it will return false, which indicates the tie. It comapres
      # the positions of the hand with Hand_ strengths to determine a winner. 
    private
  
    HAND_STRENGTHS = [:high_card, :pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush, :royal_flush].freeze
  end
  