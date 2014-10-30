class TopList
  def initialize(things)
    @things = things
  end

  def top(count, method_name)
    ResponseFrequencies.new(@things, method_name).take(count)
  end

  private

  class ResponseFrequencies
    def initialize(things, method_name)
      @things = things
      @method_name = method_name
    end

    def take(count)
      responses_to_message.take(count)
    end

    private

    def responses_to_message
      responses_sorted_by_frequency.map(&:first)
    end

    def responses_sorted_by_frequency
      values_and_their_count.sort_by(&:last).reverse
    end

    def values_and_their_count
      @things.inject(Hash.new(0)) do |acc, thing|
        value = thing.public_send(@method_name)
        acc[value] = acc[value] + 1
        acc
      end.to_a
    end
  end
end
