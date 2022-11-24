class Code
  class Node
    class CallArgument < Node
      def initialize(parsed)
        @value = Node::Code.new(parsed.delete(:value))
      end

      def evaluate(**args)
        ::Code::Object::Argument.new(@value.evaluate(**args))
      end
    end
  end
end
