require 'rails_helper'

describe Searcher do
  it 'finds moves' do
    move = create :move, name: 'sybil'
    results = Searcher.new(record_type: Move).search(property: 'name', query: 'sybil')
    expect(results).to eq ['sybil']
  end

  it 'does not return more than 10 things' do
    11.times { |i| create :move, name: "move #{i}" }
    results = Searcher.new(record_type: Move).search(property: 'name', query: 'move')
    expect(results.count).to eq 10
  end

  it 'is case insensitive' do
    move = create :move, name: 'sybil'
    results = Searcher.new(record_type: Move).search(property: 'name', query: 'Sybil')
    expect(results).to eq ['sybil']
  end

  it 'does not return duplicate results' do
    2.times { create :move, name: 'sybil' }
    results = Searcher.new(record_type: Move).search(property: 'name', query: 'sybil')
    expect(results.count).to eq 1
  end
end
