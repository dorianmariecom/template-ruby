class Code
  class Node
    class RegularCallArgument < Node
      def initialize(argument)
        @splat = argument.key?(:splat)
        @keyword_splat = argument.key?(:keyword_splat)
        @block = argument.key?(:block)
        @value = ::Code::Node::Code.new(argument.fetch(:value))
      end

      def evaluate(**args)
        object = @value.evaluate(**args)

        block? ? simple_call(object, :to_function, **args) : object
      end

      def block?
        @block
      end

      def splat?
        @splat
      end

      def keyword_splat?
        @keyword_splat
      end

      def name
        nil
      end
    end
  end
end
