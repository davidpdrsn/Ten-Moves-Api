class SearchesController < ApiController
  def show
    moves = Searcher.new(record_type: Move).search(property: 'name',
                                                   query: params[:query])

    render json: moves
  end
end
