require_relative "../../lib/method_chain"

describe MethodChain do
  it 'chains methods together and passes input through like a pipeline' do
    obj = SomeObject.new
    chain = MethodChain.new(obj).first(:upcase).then(:make_array)

    expect(chain.call("foo bar")).to eq ["FOO", "BAR"]
  end
end

class SomeObject
  def upcase(x)
    x.upcase
  end

  def make_array(x)
    x.split(" ")
  end
end

