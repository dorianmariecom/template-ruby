class Code
  class Node
    class Call < Node
      def initialize(parsed)
        @name = parsed.delete(:name)
        @arguments =
          parsed
            .delete(:arguments) { [] }
            .map { |argument| Node::CallArgument.new(argument) }
      end

      def evaluate(**args)
        arguments = @arguments.map { |argument| argument.evaluate(**args) }

        args.fetch(:object).call(operator: @name, arguments: arguments, **args)
      end
    end
  end
end
