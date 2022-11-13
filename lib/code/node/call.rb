class Code
  class Node
    class Call < Node
      def initialize(parsed)
        @name = parsed.delete(:name)

          @arguments =
            (parsed
              .delete(:arguments) || [])
              .map do |call_argument|
                ::Code::Node::CallArgument.new(call_argument)
              end

        if parsed.key?(:block)
          @block = ::Code::Node::CallBlock.new(parsed.delete(:block))
        end

        super(parsed)
      end

      def evaluate(**args)
        object = args.fetch(:object)

        arguments = @arguments.map { |argument| argument.evaluate(**args) }

        if @block
          arguments << ::Code::Object::Argument.new(@block.evaluate(**args))
        end

        object.call(operator: @name, arguments: arguments, **args)
      end
    end
  end
end
