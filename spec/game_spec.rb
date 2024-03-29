require_relative '../lib/game'
require_relative '../lib/deck'
require_relative '../lib/player'

RSpec.describe Game do
  describe "#initialize" do
    it "initializes the game with a deck, empty player array, pot set to 0, and current_player_index set to 0" do
      allow(Deck).to receive(:new).and_return(double("Deck"))
      game = Game.new
      expect(game.instance_variable_get(:@deck)).to be_a(Deck)
      expect(game.instance_variable_get(:@players)).to eq([])
      expect(game.instance_variable_get(:@pot)).to eq(0)
      expect(game.instance_variable_get(:@current_player_index)).to eq(0)
    end
  end

  describe "#play_round" do
    it "executes the steps for playing a round of the game" do
      game = Game.new
      allow(game).to receive(:deal_cards_to_players)
      allow(game).to receive(:conduct_betting_round)
      allow(game).to receive(:handle_discard_and_replace)
      allow(game).to receive(:conduct_betting_round)
      allow(game).to receive(:determine_winner)
      game.play_round
    end
  end
end

#the describe block sets up the context for the tests, indicating that you're describing the behavior of the Game class.
# The initialize method test   focuses specifically on testing the initialize method of the Game class. It contains expectations about what should happen when a new Game instance is created.
# the play round method t creates a new Game instance with game = Game.new. It then stubs several method calls that are expected to be called during the execution of play_round. Finally, it calls game.play_round, which triggers the execution of the play_round method.


