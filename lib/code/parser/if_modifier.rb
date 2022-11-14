class Code
  class Parser
    class IfModifier < ::Code::Parser
      def parse
        left = parse_subclass(::Code::Parser::OrKeyword)

        previous_cursor = cursor

        comments_before = parse_comments(whitespace: [SPACE])

        if left && (operator = match(IF_KEYWORD)) ||
             (operator = match(UNLESS_KEYWORD))
          comments_after = parse_comments
          right = parse_subclass(::Code::Parser::IfModifier)

          if right
            {
              if_modifier: {
                left: left,
                right: right,
                operator: operator,
                comments_before: comments_before,
                comments_after: comments_after
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            left
          end
        else
          @cursor = previous_cursor
          buffer!
          left
        end
      end
    end
  end
end
