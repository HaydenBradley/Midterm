# hand_spec.rb

require_relative '../lib/hand'
require_relative '../lib/card'

RSpec.describe Hand do
  describe "#hand_strength" do
    it "returns :three_of_a_kind for a hand with three of the same value" do
      cards = [
        Card.new("Hearts", "A"),
        Card.new("Diamonds", "A"),
        Card.new("Spades", "A"),
        Card.new("Clubs", "J"),
        Card.new("Hearts", "K")
      ]
      hand = Hand.new(cards)
      expect(hand.hand_strength).to eq(:three_of_a_kind)
    end
  end

  describe "#beats?" do
    it "returns true if the current hand wins" do
      my_hand = Hand.new([
        Card.new("Hearts", "A"),
        Card.new("Diamonds", "A"),
        Card.new("Spades", "A"),
        Card.new("Clubs", "K"),
        Card.new("Hearts", "K")
      ])
      other_hand = Hand.new([
        Card.new("Hearts", "A"),
        Card.new("Diamonds", "A"),
        Card.new("Spades", "A"),
        Card.new("Clubs", "Q"),
        Card.new("Hearts", "Q")
      ])
      expect(my_hand.beats?(other_hand)).to eq(true)
    end
  end
end
# the first example tests if a hand containing three cards with the same value and one card with a different value
# returns a three of a kind. This tests to make sure the hand_strength method is working. 
# In the second example it checks the beats? method. The first hand has 4 aces and the secon has a full house. This tests to see if 
# it is really catching the logic not just matching pairs.  