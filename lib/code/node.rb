class Code
  class Node
    private

    def simple_call(object, operator, value = nil)
      puts "OBJECT: #{object.inspect}"
      puts "OPERATOR: #{operator.inspect}"
      puts "VALUE: #{value.inspect}"
      object.call(
        operator: operator && ::Code::Object::String.new(operator.to_s),
        arguments: [value && ::Code::Object::Argument.new(value)].compact
      )
    end
  end
end
