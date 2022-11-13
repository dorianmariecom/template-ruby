class Code
  class Node
    class Negation < Node
      PLUS = ::Code::Parser::PLUS

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @statement = ::Code::Node::Statement.new(parsed.delete(:statement))
        super(parsed)
      end

      def evaluate(**args)
        statement = @statement.evaluate(**args)

        if @operator = PLUS
          statement
        else
          raise NotImplementedEror.new(@operator)
        end
      end
    end
  end
end
