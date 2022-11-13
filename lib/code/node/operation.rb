class Code
  class Node
    class Operation < Node
      def initialize(parsed)
        @left = ::Code::Node::Statement.new(parsed.delete(:left))
        @rest = parsed.delete(:right).map do |right|
          ::Code::Node::Operator.new(right)
        end

        super(parsed)
      end

      def evaluate(**args)
        left = @left.evaluate(**args)

        @rest.each do |operator|
          right = operator.statement.evaluate(**args)

          left = left.call(
            operator: operator.operator,
            arguments: [::Code::Object::Argument.new(right)],
            **args
          )
        end

        left
      end
    end
  end
end
