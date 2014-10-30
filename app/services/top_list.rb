class TopList
  def initialize(things)
    @things = things
  end

  def top(count, method_name)
    values_and_their_count(method_name)
      .to_a
      .sort_by(&:last)
      .reverse
      .take(10)
      .map(&:first)
  end

  private

  def values_and_their_count(method_name)
    @things.inject(Hash.new(0)) do |acc, thing|
      value = thing.public_send(method_name)
      acc[value] = acc[value] + 1
      acc
    end
  end
end
