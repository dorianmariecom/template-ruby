class Code
  class Node
    class Boolean < Node
      TRUE_KEYWORD = ::Code::Parser::TRUE_KEYWORD
      FALSE_KEYWORD = ::Code::Parser::FALSE_KEYWORD

      def initialize(parsed)
        @boolean = parsed
      end

      def evaluate(**args)
        if @boolean == TRUE_KEYWORD
          ::Code::Object::Boolean.new(true)
        elsif @boolean == FALSE_KEYWORD
          ::Code::Object::Boolean.new(false)
        else
          raise NotImplementedError.new(@boolean)
        end
      end
    end
  end
end
