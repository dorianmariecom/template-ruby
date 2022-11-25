class Code
  class Node
    class UnaryMinus < Node
      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @right = Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        @right.evaluate(**args).call(operator: @operator, arguments: [], **args)
      end
    end
  end
end
