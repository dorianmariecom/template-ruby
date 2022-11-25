class Code
  class Node
    class CallArgument < Node
      def initialize(parsed)
        @value = Node::Code.new(parsed.delete(:value))
        @name = parsed.delete(:name)
      end

      def evaluate(**args)
        if @name
          ::Code::Object::Argument.new(
            @value.evaluate(**args),
            name: ::Code::Object::String.new(@name)
          )
        else
          ::Code::Object::Argument.new(@value.evaluate(**args))
        end
      end
    end
  end
end
