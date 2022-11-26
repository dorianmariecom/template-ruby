class Code
  class Node
    class IfModifier < Node
      IF_KEYWORD = "if"
      UNLESS_KEYWORD = "unless"
      WHILE_KEYWORD = "while"
      UNTIL_KEYWORD = "until"

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @left = Node::Statement.new(parsed.delete(:left))
        @right = Node::Statement.new(parsed.delete(:right))
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

          while @right.evaluate(**args).truthy?
            last = @left.evaluate(**args)
          end

          last
        elsif @operator == UNTIL_KEYWORD
          last = ::Code::Object::Nothing.new

          while @right.evaluate(**args).falsy?
            last = @left.evaluate(**args)
          end

          last
        else
          raise NotImplementedError.new(@operator)
        end
      end
    end
  end
end
