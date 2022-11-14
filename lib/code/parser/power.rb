class Code
  class Parser
    class Power < ::Code::Parser
      def parse
        left = parse_subclass(::Code::Parser::Negation)
        previous_cursor = cursor
        comments_before = parse_comments
        if match(ASTERISK + ASTERISK)
          comments_after = parse_comments
          right = parse_subclass(::Code::Parser::Power)
          if right
            {
              power: {
                left: left,
                right: right,
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
