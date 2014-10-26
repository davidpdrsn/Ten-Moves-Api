require 'rails_helper'

describe MovesController do
  describe '#index' do
    it 'returns the most recent moves' do
      move = create(:move)

      get :index, format: :json, api_key: ENV["api_key"]

      expect(json_response[0]).to eq(move.name)
    end

    it 'requires the api key' do
      get :index, format: :json, api_key: "wrong-key"
      expect(json_response['error']).to_not be_nil
      expect(response.status).to eq(401)
    end
  end

  describe '#create' do
    it 'creates new moves' do
      expect do
        post :create, format: :json, api_key: ENV["api_key"], move: { name: "a move" }
      end.to change { Move.count }.by 1

      expect(response.status).to eq(201)
    end

    it 'does not create the move if its invalid' do
      expect do
        post :create, format: :json, api_key: ENV["api_key"], move: { name: '' }
      end.not_to change { Move.count }

      expect(response.status).to eq(422)
    end

    it 'does not create the move params are missing' do
      expect do
        post :create, format: :json, api_key: ENV["api_key"]
      end.not_to change { Move.count }

      expect(response.status).to eq(422)
    end

    it 'normalizes the input' do
      post :create, format: :json, api_key: ENV["api_key"], move: { name: "a move" }
      expect(Move.first.name).to eq "A Move"
    end
  end

  describe '#delete' do
    it 'deletes moves' do
      move = create :move
      delete "delete_move_by_name", api_key: ENV["api_key"], name: move.name

      expect(Move.count).to eq 0
      expect(response.status).to eq 200
    end

    it 'does not require the name to be normalized in the params' do
      move = create :move, name: "Mocking Bird"
      delete "delete_move_by_name", api_key: ENV["api_key"], name: 'mocking bird'

      expect(Move.count).to eq 0
      expect(response.status).to eq 200
    end

    it "doesn't delete moves that are not there" do
      delete "delete_move_by_name", api_key: ENV["api_key"], name: "not a name"

      expect(response.status).to eq 422
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
