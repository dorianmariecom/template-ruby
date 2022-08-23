class Code
  class Node
    class Rescue < Node
      def initialize(power)
        @left = ::Code::Node::Statement.new(power.fetch(:left))
        @right = ::Code::Node::Statement.new(power.fetch(:right))
      end

      def evaluate(**args)
        @left.evaluate(**args)
      rescue ::Code::Error
        @right.evaluate(**args)
      end
    end
  end
end
