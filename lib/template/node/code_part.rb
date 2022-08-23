class Template
  class Node
    class CodePart
      def initialize(code)
        @code = ::Code::Node::Code.new(code)
      end

      def evaluate(**args)
        @code.evaluate(**args)
      end
    end
  end
end
