class Code
  class Node
    EQUAL = ::Code::Parser::EQUAL

    class Equal < Node
      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = parsed.delete(:left)
        @right = ::Code::Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        right = @right.evaluate(**args)
        context = args.fetch(:context)

        if @left.is_a?(Hash)
          raise NotImplementedError.new(@left.inspect)
        elsif @operator == EQUAL
          context[@left] = right
        else
          operator = @operator.delete_suffix(EQUAL)

          context[@left] = context[@left].call(
            operator: operator,
            arguments: [::Code::Object::Argument.new(right)],
            **args
          )
        end
      end
    end
  end
end
