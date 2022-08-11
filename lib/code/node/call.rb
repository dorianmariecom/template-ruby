class Code
  class Node
    class Call
      def initialize(call)
        @left = ::Code::Node::Statement.new(call.fetch(:left))

        @arguments = call.fetch(:arguments, [])
        @arguments.map! do |argument|
          ::Code::Node::CallArgument.new(argument)
        end

        if call.key?(:right)
          @right = ::Code::Node::Statement.new(call.fetch(:right))
        end
      end

      def evaluate(context)
        if @right
          context = @left.evaluate(context)
          @right.evaluate(context)
        else
          if @left.statement.is_a?(::Code::Node::Name)
            function = @left.statement.evaluate(context, call_function: false)
            function.call(context, *arguments(context))
          else
            raise NotImplementedError.new(@left.inspect)
          end
        end
      end

      private

      def arguments(context)
        @arguments.map do |argument|
          argument.evaluate(context)
        end
      end
    end
  end
end
