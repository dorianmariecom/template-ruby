class Code
  class Node
    class While < Node
      WHILE_KEYWORD = :while
      UNTIL_KEYWORD = :until

      def initialize(while_parsed)
        @operator = while_parsed.fetch(:operator)
        @statement = ::Code::Node::Statement.new(while_parsed.fetch(:statement))
        @body = ::Code::Node::Code.new(while_parsed.fetch(:body))
      end

      def evaluate(**args)
        if operator == WHILE_KEYWORD
          object = ::Code::Object::Nothing.new

          while @statement.evaluate(**args).truthy?
            object = @body.evaluate(**args)
          end

          object
        elsif operator == UNTIL_KEYWORD
          object = ::Code::Object::Nothing.new

          until @statement.evaluate(**args).truthy?
            object = @body.evaluate(**args)
          end

          object
        else
          raise NotImplementedError.new(operator.inspect)
        end
      end

      private

      def operator
        @operator.to_sym
      end
    end
  end
end
