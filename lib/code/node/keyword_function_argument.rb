class Code
  class Node
    class KeywordFunctionArgument < Node
      def initialize(argument)
        @name = argument.fetch(:name)

        if argument.key?(:default)
          @default = ::Code::Node::Code.new(argument.fetch(:default))
        end
      end

      def evaluate(**args)
        @default ? @default.evaluate(**args) : ::Code::Object::Nothing.new
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

      def block?
        false
      end
    end
  end
end
