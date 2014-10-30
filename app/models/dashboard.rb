class Dashboard
  attr_reader :count, :top_list

  def initialize(count, top_list)
    @count = count
    @top_list = top_list
  end

  def empty?
    @count == 0
  end
end
