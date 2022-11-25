class Code
  class Node
    class Call < Node
      class Block < Node
        def initialize(parsed)
          @parameters =
            parsed
              .delete(:parameters) { [] }
              .map { |parameter| Node::FunctionParameter.new(parameter) }

          @body = Node::Code.new(parsed.delete(:body))

          super(parsed)
        end

        def evaluate(**args)
          ::Code::Object::Argument.new(
            ::Code::Object::Function.new(parameters: @parameters, body: @body)
          )
        end
      end

      def initialize(parsed)
        @name = parsed.delete(:name)
        @arguments =
          parsed
            .delete(:arguments) { [] }
            .map { |argument| Node::CallArgument.new(argument) }

        if parsed.key?(:block)
          @block = Node::Call::Block.new(parsed.delete(:block))
        end

        super(parsed)
      end

      def evaluate(**args)
        arguments = @arguments.map { |argument| argument.evaluate(**args) }

        arguments << @block.evaluate(**args) if @block

        args.fetch(:object).call(operator: @name, arguments: arguments, **args)
      end
    end
  end
end
