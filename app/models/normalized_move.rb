require 'delegate'

class NormalizedMove < SimpleDelegator
  def initialize(move, normalizer)
    super(move)
    @normalizer = normalizer
  end

  def normalized_name
    @normalizer.normalize(name)
  end
end
