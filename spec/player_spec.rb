require_relative '../lib/player'

RSpec.describe Player do
  let(:player) { Player.new }

  describe "#initialize" do
    it "initializes the player with an empty hand and pot set to 0" do
      expect(player.hand).to eq([])
      expect(player.pot).to eq(0)
    end
  end

  describe "#discard" do
    before do
      player.hand = [10, 20, 30, 40, 50]
      allow(player).to receive(:gets).and_return("1 3\n")
      player.discard
    end

    it "removes specified cards from the hand" do
      expect(player.hand).to eq([20, 40, 50])
    end
  end

  describe "#decide_action" do
    context "when player chooses to fold" do
      before { allow(player).to receive(:gets).and_return("fold\n") }

      it "returns :fold" do
        expect(player.decide_action(10)).to eq(:fold)
      end
    end

    context "when player chooses to see and has enough chips" do
      before do
        player.pot = 20
        allow(player).to receive(:gets).and_return("see\n")
      end

      it "returns :see" do
        expect(player.decide_action(10)).to eq(:see)
      end
    end

    context "when player chooses to raise and has enough chips" do
      before do
        player.pot = 20
        allow(player).to receive(:gets).and_return("raise 10\n")
      end

      it "returns :raise and the raise amount" do
        expect(player.decide_action(10)).to eq([:raise, 10])
      end
    end

    context "when player's action is invalid or does not have enough money" do
      before { allow(player).to receive(:gets).and_return("invalid\n", "see\n") }

      it "retries the action" do
        expect(player).to receive(:puts).with("Invalid or not enough money").once
        player.decide_action(10)
      end
    end
  end
end

# The first describe block tests the initialization of the Player object. It verifies that upon initialization, the player's hand is empty and their pot is set to 0.
# The second describe block tests the discard method of the Player class. It sets up a player with a hand containing five cards and simulates discarding cards at positions 1 and 3. It then verifies that the specified cards have been removed from the player's hand.
# The decide action is testing for : when the player chooses to fold. When the player chooses to see and has enough chips. When the players action is invalid. Each context block gives unique conditions.
