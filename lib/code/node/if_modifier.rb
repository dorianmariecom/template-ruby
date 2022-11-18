class Code
  class Node
    class IfModifier < Node
      IF_KEYWORD = ::Code::Parser::IF_KEYWORD
      UNLESS_KEYWORD = ::Code::Parser::UNLESS_KEYWORD
      WHILE_KEYWORD = ::Code::Parser::WHILE_KEYWORD
      UNTIL_KEYWORD = ::Code::Parser::UNTIL_KEYWORD

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = ::Code::Node::Statement.new(parsed.delete(:left))
        @right = ::Code::Node::Statement.new(parsed.delete(:right))
        super(parsed)
      end

      def evaluate(**args)
        if @operator == IF_KEYWORD
          if @right.evaluate(**args).truthy?
            @left.evaluate(**args)
          else
            ::Code::Object::Nothing.new
          end
        elsif @operator == UNLESS_KEYWORD
          if @right.evaluate(**args).falsy?
            @left.evaluate(**args)
          else
            ::Code::Object::Nothing.new
          end
        elsif @operator == WHILE_KEYWORD
          last = ::Code::Object::Nothing.new

          last = @left.evaluate(**args) while @right.evaluate(**args).truthy?

          last
        elsif @operator == UNTIL_KEYWORD
          last = ::Code::Object::Nothing.new

          last = @left.evaluate(**args) while @right.evaluate(**args).falsy?

          last
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
