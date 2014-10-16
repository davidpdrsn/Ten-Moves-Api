require 'rails_helper'

describe Move do
  describe '.most_recent' do
    it 'returns the 10 most recent moves' do
      12.times do |i|
        create(:move, name: "Sybil #{i}")
      end
      create(:move, name: 'newest move')

      expect(Move.most_recent.count).to eq(10)
      expect(Move.most_recent.first.name).to eq('newest move')
    end

    it 'returns an empty array when there are no moves' do
      expect(Move.most_recent).to eq([])
    end

    it 'returns all the moves when there are less than 10 moves' do
      create(:move, name: 'one')
      create(:move, name: 'two')
      create(:move, name: 'three')

      expect(Move.most_recent.map(&:name)).to eq(['three', 'two', 'one'])
    end
  end
end
