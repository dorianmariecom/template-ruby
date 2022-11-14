class Code
  class Parser
    class Equal < ::Code::Parser
      def parse
        previous_cursor = cursor

        left = parse_left

        comments_before = parse_comments

        if left && operator = match(EQUALS)
          comments_after = parse_comments

          right = parse_subclass(::Code::Parser::Equal)

          if right
            {
              equal: {
                operator: operator,
                left: left,
                right: right,
                comments_before: comments_before,
                comments_after: comments_after
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            parse_next
          end
        else
          @cursor = previous_cursor
          buffer!
          parse_next
        end
      end

      private

      def parse_next
        parse_subclass(::Code::Parser::Rescue)
      end

      def parse_left
        left = parse_subclass(::Code::Parser::Name)
        return unless left

        previous_cursor = cursor
        comments_before = parse_comments

        if match(DOT) || match(COLON + COLON)
          right = parse_subclass(::Code::Parser::Name)
          if right
            { left: left, right: right }
          else
            @cursor = previous_cursor
            buffer!
            return
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
