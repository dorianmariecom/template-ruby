class Code
  class Node
    class Power < Node
      def initialize(power)
        @left = ::Code::Node::Statement.new(power.fetch(:left))
        @right = ::Code::Node::Statement.new(power.fetch(:right))
      end

      def evaluate(context)
        right = @right.evaluate(context)
        left = @left.evaluate(context)
        simple_call(left, :**, right)
      end
    end
  end
end
