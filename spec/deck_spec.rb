# deck_spec.rb

require_relative '../lib/deck'

RSpec.describe Deck do
  describe "#initialize" do
    context "when initializing a new deck" do
      let(:deck) { Deck.new }

      it "creates a deck of 52 cards" do
        expect(deck.cards.length).to eq(52)
      end

      it "shuffles the deck" do
        expect(deck.cards).not_to eq(Deck.new.cards)
      end
    end
  end
end

# I've used a context block to group the tests related to the initialization of a new deck.
# Inside this context block, I've defined the deck variable using let, which creates a new instance of Deck for each example within this context.
