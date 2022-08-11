class Code
  class Node
    class CallArgument
      REGULAR = :regular
      KEYWORD = :keyword

      attr_reader :kind

      def initialize(argument)
        if argument.key?(:regular)
          @kind = REGULAR
          @argument =
            ::Code::Node::RegularCallArgument.new(argument.fetch(:regular))
        elsif argument.key?(:keyword)
          @kind = KEYWORD
          @argument =
            ::Code::Node::KeywordCallArgument.new(argument.fetch(:keyword))
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

      def name
        keyword? ? @argument.name : nil
      end
    end
  end
end
