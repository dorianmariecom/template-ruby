class Code
  class Node
    class List < Node
      def initialize(parsed)
        @elements = parsed.map { |element| ::Code::Node::Code.new(element) }
      end

      def evaluate(**args)
        ::Code::Object::List.new(
          @elements.map { |element| element.evaluate(**args) }
        )
      end
    end
  end
end
