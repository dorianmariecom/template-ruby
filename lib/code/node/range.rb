class Code
  class Node
    class Range
      INCLUSIVE_RANGE = ".."
      EXCLUSIVE_RANGE = "..."

      def initialize(range)
        @left = ::Code::Node::Statement.new(range.fetch(:left))
        @operator = range.fetch(:operator)
        @right = ::Code::Node::Statement.new(range.fetch(:right))
      end

      def evaluate(context)
        left = @left.evaluate(context)
        right = @right.evaluate(context)

        if operator == INCLUSIVE_RANGE
          ::Code::Object::Range.new(left, right, exclude_end: false)
        elsif operator == EXCLUSIVE_RANGE
          ::Code::Object::Range.new(left, right, exclude_end: true)
        else
          raise NotImplementedError.new(operator)
        end
      end

      private

      attr_reader :operator
    end
  end
end