class Code
  class Node
    class Not < Node
      def initialize(parsed)
        @right = ::Code::Node::Statement.new(parsed.delete(:right))

        super(parsed)
      end

      def evaluate(**args)
        right = @right.evaluate(**args)

        if right.truthy?
          ::Code::Object::Boolean.new(false)
        else
          ::Code::Object::Boolean.new(true)
        end
      end
    end
  end
end
