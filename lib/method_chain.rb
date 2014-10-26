class MethodChain
  def initialize(obj, methods = [])
    @obj = obj
    @methods = methods
  end

  def then(method_name)
    new_method = @obj.method(method_name)
    MethodChain.new(@obj, @methods + [new_method])
  end

  alias :first :then

  def call(obj)
    @methods.inject(obj) do |acc, method|
      method.call(acc)
    end
  end
end
