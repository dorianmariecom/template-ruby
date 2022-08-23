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

      def evaluate(**args)
        left = @left.evaluate(**args)

        if left.truthy?
          @middle.evaluate(**args)
        elsif @right
          @right.evaluate(**args)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
