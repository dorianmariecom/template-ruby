class Code
  class Node
    class Power
      def initialize(power)
        @left = ::Code::Node::Statement.new(power.fetch(:left))
        @right = ::Code::Node::Statement.new(power.fetch(:right))
      end

      def evaluate(context)
        right = @right.evaluate(context)
        left = @left.evaluate(context)
        left.evaluate(:**, right)
      end
    end
  end
end
