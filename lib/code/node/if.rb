class Code
  class Node
    class If < Node
      IF_KEYWORD = "if"
      UNLESS_KEYWORD = "unless"
      ELSIF_KEYWORD = "elsif"
      ELSE_KEYWORD = "else"

      class Else < Node
        attr_reader :operator, :statement, :body

        def initialize(parsed)
          @operator = parsed.delete(:operator)
          @body = Node::Code.new(parsed.delete(:body))

          if parsed.key?(:statement)
            @statement = Node::Statement.new(parsed.delete(:statement))
          end
        end
      end

      def initialize(parsed)
        @first_operator = parsed.delete(:first_operator)
        @first_statement = Node::Statement.new(parsed.delete(:first_statement))
        @first_body = Node::Code.new(parsed.delete(:first_body))
        @elses =
          parsed.delete(:elses) { [] }.map { |elses| Node::If::Else.new(elses) }
        super(parsed)
      end

      def evaluate(**args)
        if @first_operator == IF_KEYWORD &&
             @first_statement.evaluate(**args).truthy?
          @first_body.evaluate(**args)
        elsif @first_operator == UNLESS_KEYWORD &&
              @first_statement.evaluate(**args).falsy?
          @first_body.evaluate(**args)
        else
          @elses.each do |elses|
            if elses.operator == ELSIF_KEYWORD &&
                 elses.statement.evaluate(**args).truthy?
              return elses.body.evaluate(**args)
            elsif elses.operator == IF_KEYWORD &&
                  elses.statement.evaluate(**args).truthy?
              return elses.body.evaluate(**args)
            elsif elses.operator == UNLESS_KEYWORD &&
                  elses.statement.evaluate(**args).falsy?
              return elses.body.evaluate(**args)
            elsif elses.operator == ELSE_KEYWORD
              return elses.body.evaluate(**args)
            end
          end

          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
