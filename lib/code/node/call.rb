class Code
  class Node
    class Call
      def initialize(call)
        @left = ::Code::Node::Statement.new(call.fetch(:left))
        @right = ::Code::Node::Statement.new(call.fetch(:right))
      end

      def evaluate(context)
        context = left.evaluate(context)
        right.evaluate(context)
      end

      private

      attr_reader :left, :right
    end
  end
end
