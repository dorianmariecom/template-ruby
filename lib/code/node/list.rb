class Code
  class Node
    class List
      def initialize(codes)
        @codes = codes.map { |code| ::Code::Node::Code.new(code) }
      end

      def evaluate(context)
        ::Code::Object::List.new(@codes.map { |code| code.evaluate(context) })
      end
    end
  end
end
