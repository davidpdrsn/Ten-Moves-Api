class MovesController < ApplicationController
  before_action :restrict_access
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
    move = NormalizedMove.new(Move.new(move_params), normalizer)
    move.name = move.normalized_name

    if move.save!
      render json: move, status: :created
    end
  end

  def delete_move_by_name
    move = Move.all.detect { |move| normalizer.normalize(params[:name]) == move.name }

    if move.try(:destroy)
      render nothing: true
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def move_params
    params.require(:move).permit(:name)
  end

  def restrict_access
    head :unauthorized unless params[:api_key] == ENV['api_key']
  end

  def normalizer
    NormalizeMoveName.new(MethodChain)
  end
end
