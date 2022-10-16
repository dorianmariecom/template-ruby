class Code
  class Node
    class Call < Node
      def initialize(call)
        @left = ::Code::Node::Statement.new(call.fetch(:left))

        @arguments = call.fetch(:arguments, [])
        @arguments.map! { |argument| ::Code::Node::CallArgument.new(argument) }

        if call.key?(:right)
          @right =
            call
              .fetch(:right)
              .map { |right| ::Code::Node::ChainedCall.new(right) }
        end

        if call.key?(:block)
          @block = ::Code::Node::Block.new(call.fetch(:block))
        end
      end

      def evaluate(**args)
        if @right
          left = @left.evaluate(**args)

          @right.reduce(left) do |acc, element|
            element.evaluate(**args.merge(object: acc))
          end
        else
          arguments =
            @arguments.map do |argument|
              ::Code::Object::Argument.new(
                argument.evaluate(**args),
                name: argument.name,
                splat: argument.splat?,
                keyword_splat: argument.keyword_splat?,
                block: argument.block?,
              )
            end

          if @block
            arguments << ::Code::Object::Argument.new(
              @block.evaluate(**args),
              block: true,
            )
          end

          @left.evaluate(**args.merge(arguments: arguments))
        end
      end
    end
  end
end
