class Code
  class Node
    class Splat < Node
      AMPERSAND = ::Code::Parser::AMPERSAND
      ASTERISK = ::Code::Parser::ASTERISK

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @right = ::Code::Node::Statement.new(parsed.delete(:right))

        super(parsed)
      end

      def evaluate(**args)
        if block?
          right = @right.evaluate(**args)
          right.call(operator: "to_function", arguments: [], **args)
        else
          raise NotImplementedError
        end
      end

      private

      attr_reader :operator

      def block?
        operator == AMPERSAND
      end

      def keyword_splat?
        operator == ASTERISK + ASTERISK
      end

      def regular_splat?
        operator = ASTERISK
      end
    end
  end
end
