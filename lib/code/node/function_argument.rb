class Code
  class Node
    class FunctionArgument < Node
      def initialize(argument)
        if argument.key?(:regular)
          @argument =
            ::Code::Node::RegularFunctionArgument.new(argument.fetch(:regular))
        elsif argument.key?(:keyword)
          @argument =
            ::Code::Node::KeywordFunctionArgument.new(argument.fetch(:keyword))
        else
          raise NotImplementedError.new(argument.inspect)
        end
      end

      def evaluate(context)
        @argument.evaluate(context)
      end

      def splat?
        @argument.splat?
      end

      def keyword_splat?
        @argument.keyword_splat?
      end

      def name
        @argument.name
      end

      def block?
        @argument.block?
      end

      def regular?
        @argument.is_a?(::Code::Node::RegularFunctionArgument)
      end

      def keyword?
        @argument.is_a?(::Code::Node::KeywordFunctionArgument)
      end
    end
  end
end
