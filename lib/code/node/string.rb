class Code
  class Node
    class String < Node
      def initialize(parsed)
        if parsed.is_a?(::String)
          @string = parsed
        else
          @string = parsed.map { |part| ::Template::Node::Part.new(part) }
        end
      end

      def evaluate(**args)
        if @string.is_a?(::String)
          ::Code::Object::String.new(@string)
        else
          ::Code::Object::String.new(
            @string.map { |part| part.evaluate(**args) }.join
          )
        end
      end
    end
  end
end
