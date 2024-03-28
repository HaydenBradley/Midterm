class Card
    attr_reader :suit, :value #This line creates getter methods for the @suit and @value instance variables.
  
    def initialize(suit, value) #This is the constructor method of the Card class ex: 
      @suit = suit
      @value = value #These instance variables hold the suit and value of each card object.
    end
  end