class TopList
  def initialize(things)
    @things = things
  end

  def top(count, method_name)
    responses_to_message(method_name).take(count)
  end

  private

  def responses_to_message(method_name)
    responses_grouped_by_frequency(method_name).map(&:first)
  end

  def responses_grouped_by_frequency(method_name)
    values_and_their_count(method_name).sort_by(&:last).reverse
  end

  def values_and_their_count(method_name)
    @things.inject(Hash.new(0)) do |acc, thing|
      value = thing.public_send(method_name)
      acc[value] = acc[value] + 1
      acc
    end.to_a
  end
end
