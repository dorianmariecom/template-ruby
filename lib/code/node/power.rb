class Code
  class Node
    class Power < Node
      def initialize(parsed)
        @left = ::Code::Node::Statement.new(parsed.delete(:left))
        @right = ::Code::Node::Statement.new(parsed.delete(:right))

        super(parsed)
      end

      def evaluate(**args)
        right = @right.evaluate(**args)
        left = @left.evaluate(**args)

        left.call(
          operator: "**",
          arguments: [::Code::Object::Argument.new(right)],
          **args
        )
      end
    end
  end
end
