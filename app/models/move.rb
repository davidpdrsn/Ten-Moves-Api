class Move < ActiveRecord::Base
  validates :name, presence: true

  def self.most_popular_names
    popular_names_and_their_frequencies.take(10).map(&:first)
  end

  private

  def self.number_of_times_names_appear
    Move.all.group_by(&:name).inject([]) do |acc, (key, value)|
      acc << [key, value.count]
    end
  end

  def self.popular_names_and_their_frequencies
    number_of_times_names_appear.sort_by(&:last).reverse
  end
end
