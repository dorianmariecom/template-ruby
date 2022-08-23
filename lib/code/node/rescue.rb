class Code
  class Node
    class Rescue < Node
      def initialize(power)
        @left = ::Code::Node::Statement.new(power.fetch(:left))
        @right = ::Code::Node::Statement.new(power.fetch(:right))
      end

      def evaluate(context)
        @left.evaluate(context)
      rescue ::Code::Error
        @right.evaluate(context)
      end
    end
  end
end
