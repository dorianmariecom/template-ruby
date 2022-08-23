class Code
  class Node
    class Group < Node
      def initialize(group)
        @code = ::Code::Node::Code.new(group)
      end

      def evaluate(context)
        @code.evaluate(context)
      end
    end
  end
end
