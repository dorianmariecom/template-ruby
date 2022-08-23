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

      def evaluate(context, arguments: [])
        if @right
          left = @left.evaluate(context)

          arguments = @arguments.map do |argument|
            ::Code::Object::Argument.new(
              argument.evaluate(context),
              name: argument.name,
              splat: argument.splat?,
              keyword_splat: argument.keyword_splat?,
              block: argument.block?,
            )
          end

          if @block
            arguments << ::Code::Object::Argument.new(
              @block.evaluate(context),
              block: true
            )
          end

          @right.statement.evaluate(left, arguments: arguments)
        else
          arguments = @arguments.map do |argument|
            ::Code::Object::Argument.new(
              argument.evaluate(context),
              name: argument.name,
              splat: argument.splat?,
              keyword_splat: argument.keyword_splat?,
              block: argument.block?,
            )
          end

          if @block
            arguments << ::Code::Object::Argument.new(
              @block.evaluate(context),
              block: true
            )
          end

          @left.statement.evaluate(context, arguments: arguments)
        end
      end
    end
  end
end
