class Code
  class Node
    class RegularFunctionArgument < Node
      def initialize(argument)
        @block = argument.key?(:block)
        @splat = argument.key?(:splat)
        @keyword_splat = argument.key?(:keyword_splat)
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
        @splat
      end

      def keyword_splat?
        @keyword_splat
      end

      def block?
        @block
      end
    end
  end
end
