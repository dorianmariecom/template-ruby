class Code
  class Node
    class FunctionArgument
      REGULAR = :regular
      KEYWORD = :keyword

      attr_reader :kind

      def initialize(argument)
        if argument.key?(:regular)
          @kind = REGULAR
          @argument =
            ::Code::Node::RegularFunctionArgument.new(argument.fetch(:regular))
        elsif argument.key?(:keyword)
          @kind = KEYWORD
          @argument =
            ::Code::Node::KeywordFunctionArgument.new(argument.fetch(:keyword))
        else
          raise NotImplementedError.new(argument.inspect)
        end
      end

      def evaluate(context)
        @argument.evaluate(context)
      end

      def regular?
        kind == REGULAR
      end

      def keyword?
        kind == KEYWORD
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
    end
  end
end
