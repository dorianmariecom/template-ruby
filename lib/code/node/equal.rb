class Code
  class Node
    class Equal < Node
      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = parsed.delete(:left)
        @right = Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        right = @right.evaluate(**args)
        left = ::Code::Object::String.new(@left)
        context = args.fetch(:context)

        if @operator == ""
          context[left] = right
        else
          if context[left].nil?
            raise ::Code::Error::Undefined.new("#{left} is not defined")
          end

          context[left] = context.fetch(left).call(
            operator: @operator,
            arguments: [::Code::Object::Argument.new(right)],
            **args
          )
        end

        args[:context][left]
      end
    end
  end
end
