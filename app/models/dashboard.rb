class Dashboard
  attr_reader :total_moves_count, :top_list

  def initialize(total_moves_count, top_list)
    @total_moves_count = total_moves_count
    @top_list = top_list
  end

  def empty?
    @total_moves_count == 0
  end
end
