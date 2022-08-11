class Code
  class Node
    class KeywordCallArgument
      def initialize(argument)
        @name = argument.fetch(:name)
        @value = ::Code::Node::Code.new(argument.fetch(:value))
      end

      def evaluate(context)
        @value.evaluate(context)
      end

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
