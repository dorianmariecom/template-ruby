class Code
  class Node
    class Rescue < Node
      def initialize(parsed)
        @left = Node::Statement.new(parsed.delete(:left))
        @right = Node::Statement.new(parsed.delete(:right))
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
