class Code
  class Node
    class CallArgument < Node
      def initialize(argument)
        if argument.key?(:regular)
          @argument =
            ::Code::Node::RegularCallArgument.new(argument.fetch(:regular))
        elsif argument.key?(:keyword)
          @argument =
            ::Code::Node::KeywordCallArgument.new(argument.fetch(:keyword))
        else
          raise NotImplementedError.new(argument.inspect)
        end
      end

      def evaluate(**args)
        @argument.evaluate(**args)
      end

      def name
        @argument.name
      end

      def block?
        @argument.block?
      end

      def splat?
        @argument.splat?
      end

      def keyword_splat?
        @argument.keyword_splat?
      end
    end
  end
end
