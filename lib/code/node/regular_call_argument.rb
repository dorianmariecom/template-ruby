class Code
  class Node
    class RegularCallArgument
      def initialize(argument)
        @block = argument.key?(:block)
        @value = ::Code::Node::Code.new(argument.fetch(:value))
      end

      def evaluate(context)
        object = @value.evaluate(context)

        if block?
          object.evaluate(:to_function)
        else
          object
        end
      end

      private

      def block?
        @block
      end
    end
  end
end
