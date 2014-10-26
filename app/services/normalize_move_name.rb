require_relative '../../lib/method_chain'

class NormalizeMoveName
  def initialize(method_chain_factory)
    @method_chain_factory = method_chain_factory
  end

  def normalize(name)
    @method_chain_factory.new(self)
      .first(:titleize)
      .then(:remove_trailing_whitespace)
      .then(:remove_leading_whitespace)
      .call(name)
  end

  private

  def titleize(name)
    name.titleize
  end

  def remove_trailing_whitespace(name)
    name.gsub(/\s*$/, "")
  end

  def remove_leading_whitespace(name)
    name.gsub(/^\s*/, "")
  end
end
