class Code
  class Node
    class Power < Node
      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = Node::Statement.new(parsed.delete(:left))
        @right = Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        @left.evaluate(**args).call(
          operator: @operator,
          arguments: [::Code::Object::Argument.new(@right.evaluate(**args))],
          **args
        )
      end
    end
  end
end
