require_relative '../lib/game'

RSpec.describe Game do
  let(:deck) { instance_double("Deck") }
  let(:player1) { instance_double("Player") }
  let(:player2) { instance_double("Player") }

  before do
    allow(Deck).to receive(:new).and_return(deck)
    allow(deck).to receive(:deal).and_return("Card1", "Card2", "Card3", "Card4", "Card5")
  end

  describe "#initialize" do
    it "initializes the game with a deck, empty player array, pot set to 0, and current_player_index set to 0" do
      game = Game.new
      expect(game.instance_variable_get(:@deck)).to eq(deck)
      expect(game.instance_variable_get(:@players)).to eq([])
      expect(game.instance_variable_get(:@pot)).to eq(0)
      expect(game.instance_variable_get(:@current_player_index)).to eq(0)
    end
  end

  describe "#play_round" do
    it "executes the steps for playing a round of the game" do
      game = Game.new
      game.instance_variable_set(:@players, [player1, player2])

      expect(deck).to receive(:deal).exactly(10).times
      expect(player1).to receive(:hand=).with(["Card1", "Card2", "Card3", "Card4", "Card5"])
      expect(player2).to receive(:hand=).with(["Card1", "Card2", "Card3", "Card4", "Card5"])

      expect(game).to receive(:conduct_betting_round).twice
      expect(game).to receive(:handle_discard_and_replace).once
      expect(game).to receive(:determine_winner).once

      game.play_round
    end
  end
end
