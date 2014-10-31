require 'rails_helper'

describe AdminController do
  describe '#index' do
    it 'does not let unauthorized requests get through' do
      get :index
      expect(response.status).to eq 401
    end

    it 'does let authorized requests get through' do
      http_login
      get :index
      expect(response.status).to eq 200
    end
  end

  def http_login
    username = ENV['admin_username']
    password = ENV['admin_password']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic
      .encode_credentials(username, password)
  end
end
