class Code
  class Node
    private

    def simple_call(object, operator = nil, value = nil, **args)
      args = args.multi_fetch(*::Code::GLOBALS)
      object.call(
        operator: operator && ::Code::Object::String.new(operator.to_s),
        arguments: [value && ::Code::Object::Argument.new(value)].compact,
        **args
      )
    end
  end
end
