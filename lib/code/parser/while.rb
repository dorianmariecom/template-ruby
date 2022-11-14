class Code
  class Parser
    class While < ::Code::Parser
      def parse
        if operator = match([WHILE_KEYWORD, UNTIL_KEYWORD])
          previous_cursor = cursor

          comments = parse_comments

          condition = parse_subclass(::Code::Parser::While)

          if condition
            body = parse_code

            match(END_KEYWORD)

            {
              while: {
                operator: operator,
                comments: comments,
                condition: condition,
                body: body
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            parse_subclass(::Code::Parser::If)
          end
        else
          parse_subclass(::Code::Parser::If)
        end
      end
    end
  end
end
