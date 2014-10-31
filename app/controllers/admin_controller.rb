class AdminController < ApplicationController
  before_filter :authenticate

  def index
    top_list = TopList.new(Move.all).top(10, :name)
    @dashboard = Dashboard.new(Move.count, top_list)
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["admin_username"] && password == ENV["admin_password"]
    end
  end
end
