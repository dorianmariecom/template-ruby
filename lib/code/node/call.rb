class Code
  class Node
    class Call < Node
      def initialize(call)
        @left = ::Code::Node::Statement.new(call.fetch(:left))

        @arguments = call.fetch(:arguments, [])
        @arguments.map! { |argument| ::Code::Node::CallArgument.new(argument) }

        if call.key?(:right)
          @right = ::Code::Node::Statement.new(call.fetch(:right))
        end

        if call.key?(:block)
          @block = ::Code::Node::Block.new(call.fetch(:block))
        end
      end

      def evaluate(**args)
        if @right
          left = @left.evaluate(**args)
        end

        arguments = @arguments.map do |argument|
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
            block: true
          )
        end

        if @right
          @right.statement.evaluate(**args.merge(object: left, arguments: arguments))
        else
          @left.statement.evaluate(**args.merge(arguments: arguments))
        end
      end
    end
  end
end
