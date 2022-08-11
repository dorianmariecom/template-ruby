class Code
  class Node
    class CallArgument
      def initialize(argument)
        if argument.key?(:regular)
          @argument = ::Code::Node::RegularCallArgument.new(argument.fetch(:regular))
        else
          raise NotImplementedError.new(argument.inspect)
        end
      end

      def evaluate(context)
        @argument.evaluate(context)
      end
    end
  end
end
