class ApiController < ApplicationController
  before_action :restrict_access

  private

  def restrict_access
    head :unauthorized unless params[:api_key] == ENV['api_key']
  end
end
