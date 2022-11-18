class Code
  class Node
    class CallArgument < Node
      def initialize(parsed)
        @name = parsed.delete(:name)
        @value = ::Code::Node::Code.new(parsed.delete(:value))
        super(parsed)
      end

      def evaluate(**args)
        if @name
          ::Code::Object::Argument.new(@value.evaluate(**args), name: @name)
        else
          ::Code::Object::Argument.new(@value.evaluate(**args))
        end
      end
    end
  end
end
