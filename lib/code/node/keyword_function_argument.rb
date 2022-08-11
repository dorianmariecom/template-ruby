class Code
  class Node
    class KeywordFunctionArgument
      def initialize(argument)
        @name = argument.fetch(:name)

        if argument.key?(:default)
          @default = ::Code::Node::Code.new(argument.fetch(:default))
        end
      end

      def evaluate(context)
        @default ? @default.evaluate(context) : ::Code::Object::Nothing.new
      end

      def name
        ::Code::Object::String.new(@name.to_s)
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
