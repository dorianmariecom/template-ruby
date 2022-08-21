class Code
  class Node
    class Call
      def initialize(call)
        @left = ::Code::Node::Statement.new(call.fetch(:left))

        @arguments = call.fetch(:arguments, [])
        @arguments.map! { |argument| ::Code::Node::CallArgument.new(argument) }

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
            object = @left.statement.evaluate(context)

            if object.is_a?(::Code::Object::Function)
              object.call(context, @arguments)
            else
              ::Code::Object::Nothing.new
            end
          else
            raise NotImplementedError.new(@left.inspect)
          end
        end
      end
    end
  end
end
