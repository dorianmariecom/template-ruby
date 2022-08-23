class Code
  class Node
    class Function < Node
      def initialize(function)
        @body = ::Code::Node::Code.new(function.fetch(:body))
        @arguments = function.fetch(:arguments, [])
        @arguments.map! do |argument|
          ::Code::Node::FunctionArgument.new(argument)
        end
      end

      def evaluate(context)
        ::Code::Object::Function.new(arguments: @arguments, body: @body)
      end
    end
  end
end
