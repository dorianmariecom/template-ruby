class Code
  class Node
    class Negation < Node
      PLUS = ::Code::Parser::PLUS
      EXCLAMATION_POINT = ::Code::Parser::EXCLAMATION_POINT

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @statement = ::Code::Node::Statement.new(parsed.delete(:statement))
        super(parsed)
      end

      def evaluate(**args)
        statement = @statement.evaluate(**args)

        if @operator == PLUS
          statement
        elsif @operator == EXCLAMATION_POINT
          if statement.truthy?
            ::Code::Object::Boolean.new(false)
          else
            ::Code::Object::Boolean.new(true)
          end
        else
          raise NotImplementedError.new(@operator)
        end
      end
    end
  end
end
