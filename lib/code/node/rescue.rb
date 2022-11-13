class Code
  class Node
    class Rescue < Node
      def initialize(parsed)
        @left = ::Code::Node::Statement.new(parsed.delete(:left))
        @right = ::Code::Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        @left.evaluate(**args)
      rescue ::Code::Error
        @right.evaluate(**args)
      end
    end
  end
end
