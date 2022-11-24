class Code
  class Node
    class Call < Node
      def initialize(parsed)
        @name = parsed.delete(:name)
        @arguments = parsed.delete(:arguments) { [] }.map do |argument|
          Node::CallArgument.new(argument)
        end
      end

      def evaluate(**args)
        arguments = @arguments.map do |argument|
          argument.evaluate(**args)
        end

        args.fetch(:object).call(
          operator: @name,
          arguments: arguments,
          **args
        )
      end
    end
  end
end
