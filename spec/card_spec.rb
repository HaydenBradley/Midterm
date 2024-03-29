# card_spec.rb

require_relative '../lib/card'

RSpec.describe Card do
  subject(:card) { Card.new("Spades", "K") }

  it "has a suit" do
    expect(card.suit).to eq("Spades")
  end

  it "has a value" do
    expect(card.value).to eq("K")
  end
end



# This RSpec test file, card_spec.rb, verifies the behavior of the Card class. 
 # It contains two examples: one for testing the #suit method and another for testing the #value method.
 # Each example creates a Card object with a specific suit and value, then expects the corresponding method to return the expected suit or value. 
 # if it does that it passes if not it fails