class Code
  class Node
    class List < Node
      def initialize(parsed)
        parsed = [] if parsed == ""
        @elements = parsed.map do |element|
          Node::Code.new(element)
        end
      end

      def evaluate(**args)
        ::Code::Object::List.new(
          @elements.map do |element|
            element.evaluate(**args)
          end
        )
      end
    end
  end
end
