require 'rails_helper'
require_relative '../../app/services/normalize_move_name'

describe NormalizeMoveName do
  describe '#normalize' do
    it "doesn't change the name if its already good" do
      expect(normalizer.normalize('Sybil')).to eq 'Sybil'
    end

    it 'capitalizes the name' do
      expect(normalizer.normalize('sybil')).to eq 'Sybil'
    end

    it 'capitalizes each word' do
      expect(normalizer.normalize('mocking bird')).to eq 'Mocking Bird'
    end

    it 'removes trailing whitespace' do
      expect(normalizer.normalize('mocking bird   ')).to eq 'Mocking Bird'
    end

    it 'removes leading whitespace' do
      expect(normalizer.normalize('   mocking bird')).to eq 'Mocking Bird'
    end

    def normalizer
      NormalizeMoveName.new(MethodChain)
    end
  end
end
