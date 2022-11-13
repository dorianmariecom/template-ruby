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
    end
  end
end
