class Code
  class Node
    class FunctionArgument
      def initialize(argument)
        if argument.key?(:regular)
          @argument = ::Code::Node::RegularFunctionArgument.new(argument.fetch(:regular))
        else
          raise NotImplementedError.new(argument.inspect)
        end
      end

      def evaluate(context)
        @argument.evaluate(context)
      end

      def name
        @argument.name
      end
    end
  end
end
