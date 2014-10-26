class TopList
  def initialize(things)
    @things = things
  end

  def top(count, method_name)
    hash_to_array(values_and_their_count(method_name))
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

  def hash_to_array(hash)
    hash.inject([]) do |acc, (value, count)|
      acc << [value, count]
    end
  end
end
