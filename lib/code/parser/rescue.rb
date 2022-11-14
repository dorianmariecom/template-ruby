class Code
  class Parser
    class Rescue < ::Code::Parser
      def parse
        left = parse_subclass(::Code::Parser::Ternary)

        previous_cursor = cursor

        comments_before = parse_comments

        if match(RESCUE_KEYWORD)
          previous_cursor = cursor
          comments_after = parse_comments
          right = parse_subclass(::Code::Parser::Rescue)

          if right
            {
              rescue: {
                left: left,
                right: right,
                comments_before: comments_before,
                comments_after: comments_after
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            { rescue: { left: left, comments_before: comments_before }.compact }
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
