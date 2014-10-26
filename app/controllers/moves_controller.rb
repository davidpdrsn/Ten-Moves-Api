class MovesController < ApplicationController
  before_action :require_api_key
  protect_from_forgery except: [:create, :delete_move_by_name]

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

  def delete_move_by_name
    move = Move.all.detect do |move|
      NormalizeMoveName.new(MethodChain).normalize(params[:name]) == move.name
    end

    if move.try(:destroy)
      render nothing: true
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def move_params
    permitted_params = params.require(:move).permit(:name)
    normalized_params(permitted_params.clone)
  end

  def require_api_key
    unless params[:api_key] == ENV["api_key"]
      render json: { error: "Wrong key" }, status: :unauthorized
    end
  end

  def normalized_params(params)
    new_params = params.clone
    new_params[:name] = NormalizeMoveName.new(MethodChain).normalize(params[:name])
    new_params
  end
end
