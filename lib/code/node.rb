class Code
  class Node
    private

    def simple_call(object, operator = nil, value = nil, **args)
      object.call(
        operator: operator && ::Code::Object::String.new(operator.to_s),
        arguments: [value && ::Code::Object::Argument.new(value)].compact,
        context: args.fetch(:context),
        io: args.fetch(:io),
        object: args.fetch(:object)
      )
    end
  end
end
