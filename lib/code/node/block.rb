class Code
  class Node
    class Block < Node
      def initialize(block)
        @body = ::Code::Node::Code.new(block.fetch(:body))
        @arguments = block.fetch(:arguments, [])
        @arguments.map! do |argument|
          ::Code::Node::FunctionArgument.new(argument)
        end
      end

      def evaluate(**args)
        ::Code::Object::Function.new(arguments: @arguments, body: @body)
      end
    end
  end
end
