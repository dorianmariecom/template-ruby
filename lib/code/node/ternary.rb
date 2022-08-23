class Code
  class Node
    class Ternary < Node
      def initialize(ternary)
        @left = ::Code::Node::Statement.new(ternary.fetch(:left))
        @middle = ::Code::Node::Statement.new(ternary.fetch(:middle))

        if ternary.key?(:right)
          @right = ::Code::Node::Statement.new(ternary.fetch(:right))
        end
      end

      def evaluate(context)
        left = @left.evaluate(context)

        if left.truthy?
          @middle.evaluate(context)
        elsif @right
          @right.evaluate(context)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
