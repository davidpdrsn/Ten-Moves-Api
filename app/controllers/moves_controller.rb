class MovesController < ApiController
  protect_from_forgery except: [:create, :delete_move_by_name]

  rescue_from ActionController::ParameterMissing, ActiveRecord::RecordInvalid do
    render json: { error: "Move params are missing or invalid" }, status: :unprocessable_entity
  end

  def index
    moves = TopList.new(Move.all).top(10, :name)
    render json: moves
  end

  def create
    move = NormalizedMove.new(Move.new(move_params), normalizer)
    move.name = move.normalized_name

    if move.save!
      render json: move, status: :created
    end
  end

  def delete_move_by_name
    move = Move.find_by(name: normalizer.normalize(params[:name]))

    if move.try(:destroy)
      render nothing: true
    else
      head :unprocessable_entity
    end
  end

  private

  def move_params
    params.require(:move).permit(:name)
  end

  def normalizer
    NormalizeMoveName.new(MethodChain)
  end
end
