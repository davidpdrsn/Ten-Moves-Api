require 'rails_helper'

describe Move do
  it { should validate_presence_of :name }

  describe '#most_popular_names' do
    it 'returns the most popular moves' do
      create(:move, name: 'one')
      create(:move, name: 'one')
      create(:move, name: 'one')
      12.times do |i|
        create(:move, name: "Sybil #{i}")
      end

      moves = Move.most_popular_names

      expect(moves.length).to eq(10)
      expect(moves).to include('one')
    end

    it 'returns an empty array when there are no moves' do
      expect(Move.most_popular_names).to eq([])
    end
  end
end
