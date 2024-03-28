require_relative 'card' #This line imports the Card class from the card.rb file located in the same directory as the current file. 
#The Deck class depends on the Card class to create individual cards.

class Deck
  attr_reader :cards #This allows other objects to access the @cards array, which represents the deck of cards.

  def initialize
    @cards = [] #Initializes an empty array to hold the cards in the deck
    build_deck # Calls the build_deck method to populate the @cards array.
    shuffle # shuffle the cards immediately after the deck is built.
  end

  def shuffle #This method shuffles the cards in the deck using the shuffle! method. Basically builds a random array.
    @cards.shuffle!
  end

  def deal #This method removes and returns the last card from the deck. This is suppose to be how a dealer would normally pass out the 
    #card at the top of the deck. 
    @cards.pop
  end

  def build_deck
    suits = %w[Hearts Diamonds Clubs Spades]
    values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits.product(values) { |suit, value| @cards << Card.new(suit, value) } #this line of code iterates over all combinations of suits and values, 
    # and it creates a new Card object for each combination, and adds it to the @cards array, which creates a deck with all 52 playing cards.
  end
end
