class Code
  class Node
    class String < Node
      def initialize(parsed)
        if parsed.is_a?(::String)
          @string = parsed
        else
          @string = parsed.map do |part|
            ::Template::Node::Part.new(part)
          end
        end
      end

      def evaluate(**args)
        if @string.is_a?(::String)
          ::Code::Object::String.new(@string)
        else
          ::Code::Object::String.new(
            @string.map do |part|
              part.evaluate(**args)
            end.join
          )
        end
      end
    end
  end
end
