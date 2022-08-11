class Code
  class Node
    class RegularCallArgument
      def initialize(argument)
        @code = ::Code::Node::Code.new(argument)
      end

      def evaluate(context)
        @code.evaluate(context)
      end
    end
  end
end
