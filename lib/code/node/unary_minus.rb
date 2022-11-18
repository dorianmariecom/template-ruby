class Code
  class Node
    class UnaryMinus < Node
      MINUS = ::Code::Parser::MINUS

      def initialize(parsed)
        @right = ::Code::Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        @right.evaluate(**args).call(operator: MINUS, arguments: [], **args)
      end
    end
  end
end
