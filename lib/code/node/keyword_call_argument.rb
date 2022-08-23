class Code
  class Node
    class KeywordCallArgument < Node
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

      def block?
        false
      end

      def splat?
        false
      end

      def keyword_splat?
        false
      end
    end
  end
end
