require 'rails_helper'

describe SearchesController do
  describe '#show' do
    it 'searches for moves' do
      move = create :move
      get :show, api_key: ENV['api_key'], query: move.name
      expect(json_response[0]).to eq move.name
    end

    it 'finds partial matches' do
      move = create :move, name: 'Mocking Bird'
      get :show, api_key: ENV['api_key'], query: 'Bird'
      expect(json_response[0]).to eq move.name
    end

    it 'is not case sensitive' do
      move = create :move, name: 'Mocking Bird'
      get :show, api_key: ENV['api_key'], query: 'bird'
      expect(json_response[0]).to eq move.name
    end

    it 'does not return more than 10 hits' do
      11.times do |i|
        create :move, name: "move #{i}"
      end
      get :show, api_key: ENV['api_key'], query: 'move'
      expect(json_response.length).to eq 10
    end

    it 'requires authentication' do
      get :show, query: 'sybil'
      expect(response.status).to eq 401
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
