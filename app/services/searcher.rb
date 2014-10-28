class Searcher
  def initialize(record_type:)
    @record_type = record_type
  end

  def search(property:, query:)
    all_matches(property, query).map(&property.to_sym).uniq
  end

  private

  def all_matches(property, query)
    Move.where("#{property} ILIKE ?", "%#{query}%").limit(10)
  end
end
