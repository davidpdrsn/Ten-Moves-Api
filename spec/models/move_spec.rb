require 'rails_helper'

describe Move do
  it { should validate_presence_of :name }

  describe "#number_of_moves_with_name" do
    it "returns the number of moves with the same name" do
      3.times { create :move, name: "Sybil" }

      expect(Move.number_of_moves_with_name("Sybil")).to eq 3
    end
  end
end
