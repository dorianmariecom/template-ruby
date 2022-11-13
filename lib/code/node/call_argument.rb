class Code
  class Node
    class CallArgument < Node
      def initialize(parsed)
        if parsed.is_a?(Array)
          @argument = ::Code::Node::Code.new(parsed)
        else
          super(parsed)
        end
      end

      def evaluate(**args)
        ::Code::Object::Argument.new(@argument.evaluate(**args))
      end
    end
  end
end
