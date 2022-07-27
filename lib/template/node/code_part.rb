class Template
  class Node
    class CodePart
      def initialize(code)
        @code = ::Code::Node::Code.new(code)
      end

      def evaluate(context)
        @code.evaluate(context)
      end
    end
  end
end
