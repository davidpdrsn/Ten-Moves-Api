class MovesController < ApplicationController
  before_action :require_api_key
  protect_from_forgery except: :create

  rescue_from ActionController::ParameterMissing, ActiveRecord::RecordInvalid do
    render json: { error: "Move params are missing or invalid" }, status: :unprocessable_entity
  end

  def index
    moves = Move.all
    top_list = TopList.new(moves)
    render json: top_list.top(10, :name)
  end

  def create
    @move = Move.new(move_params)

    if @move.save!
      render json: @move, status: :created
    end
  end

  private

  def move_params
    params.require(:move).permit(:name)
  end

  def require_api_key
    unless params[:api_key] == ENV["api_key"]
      render json: { error: "Wrong key" }, status: :unauthorized
    end
  end
end
