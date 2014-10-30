require 'delegate'

class NormalizedMove < SimpleDelegator
  def initialize(move, normalizer)
    super(move)
    @normalizer = normalizer
    normalize!
  end

  private

  def normalized_name
    @normalizer.normalize(__getobj__.name)
  end

  def normalize!
    __getobj__.name = normalized_name
  end
end
