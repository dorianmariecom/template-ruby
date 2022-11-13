class Code
  class Node
    class Block < Node
      def initialize(parsed)
        @statement = ::Code::Node::Statement.new(parsed)
      end
    end
  end
end
