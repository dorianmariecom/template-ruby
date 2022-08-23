class Code
  class Node
    class Group < Node
      def initialize(group)
        @code = ::Code::Node::Code.new(group)
      end

      def evaluate(**args)
        @code.evaluate(**args)
      end
    end
  end
end
