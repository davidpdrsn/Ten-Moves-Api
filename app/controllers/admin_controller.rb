class AdminController < ApplicationController
  def index
    top_list = TopList.new(Move.all).top(10, :name)
    @dashboard = Dashboard.new(Move.count, top_list)
  end
end
