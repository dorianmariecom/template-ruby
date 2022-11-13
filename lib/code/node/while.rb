class Code
  class Node
    class While < Node
      WHILE_KEYWORD = ::Code::Parser::WHILE_KEYWORD
      UNTIL_KEYWORD = ::Code::Parser::UNTIL_KEYWORD

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @condition = ::Code::Node::Statement.new(parsed.delete(:condition))
        @body = ::Code::Node::Code.new(parsed.delete(:body))
        super(parsed)
      end

      def evaluate(**args)
        if @operator == WHILE_KEYWORD
          last = ::Code::Object::Nothing.new

          while @condition.evaluate(**args).truthy?
            last = @body.evaluate(**args)
          end

          last
        elsif @operator == UNTIL_KEYWORD
          last = ::Code::Object::Nothing.new

          until @condition.evaluate(**args).truthy?
            last = @body.evaluate(**args)
          end

          last
        else
          raise NotImplementedError.new(@operator)
        end
      end
    end
  end
end
