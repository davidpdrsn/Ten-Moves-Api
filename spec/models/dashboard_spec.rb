require 'rails_helper'

describe Dashboard do
  describe '#count' do
    it 'returns the number of moves' do
      expect(Dashboard.new(10, double).count).to eq 10
    end
  end

  describe '#empty?' do
    it 'returns true if there are no moves' do
      expect(Dashboard.new(0, double).empty?).to be_truthy
    end

    it 'returns false if there are moves' do
      expect(Dashboard.new(1, double).empty?).to be_falsy
    end
  end
end
