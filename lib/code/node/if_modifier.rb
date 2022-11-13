class Code
  class Node
    class IfModifier < Node
      IF_KEYWORD = ::Code::Parser::IF_KEYWORD
      UNLESS_KEYWORD = ::Code::Parser::UNLESS_KEYWORD

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = ::Code::Node::Statement.new(parsed.delete(:left))
        @right = ::Code::Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        right = @right.evaluate(**args)

        if @operator == IF_KEYWORD && right.truthy?
          @left.evaluate(**args)
        elsif @operator == UNLESS_KEYWORD && right.falsy?
          @left.evaluate(**args)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
