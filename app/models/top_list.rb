class TopList
  def initialize(things)
    @things = things
  end

  def top(count, method_name)
    @things.inject(Hash.new(0)) do |acc, thing|
      value = thing.public_send(method_name)
      acc[value] = acc[value] + 1
      acc
    end.inject([]) do |acc, (value, count)|
      acc << [value, count]
    end.sort_by(&:last).reverse.take(10).map(&:first)
  end
end
