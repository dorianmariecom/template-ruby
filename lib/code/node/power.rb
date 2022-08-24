class Code
  class Node
    class Power < Node
      def initialize(power)
        @left = ::Code::Node::Statement.new(power.fetch(:left))
        @right = ::Code::Node::Statement.new(power.fetch(:right))
      end

      def evaluate(**args)
        right = @right.evaluate(**args)
        left = @left.evaluate(**args)
        simple_call(left, :**, right, **args)
      end
    end
  end
end
