require 'rails_helper'

describe NormalizedMove do
  it 'normalizes the name of the move its decorates' do
    move = build(:move)
    normalizer = double('normalizer', normalize: 'Sybil')

    normalized_move = NormalizedMove.new(move, normalizer)

    expect(normalized_move.name).to eq 'Sybil'
  end
end
