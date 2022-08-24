class Code
  class Node
    class ChainedCall < Node
      def initialize(chained_call)
        @name = ::Code::Node::Name.new(chained_call.fetch(:name))

        @arguments = chained_call.fetch(:arguments, [])
        @arguments.map! { |argument| ::Code::Node::CallArgument.new(argument) }

        if chained_call.key?(:block)
          @block = ::Code::Node::Block.new(chained_call.fetch(:block))
        end
      end

      def evaluate(**args)
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


        @name.evaluate(**args.merge(arguments: arguments))
      end
    end
  end
end
