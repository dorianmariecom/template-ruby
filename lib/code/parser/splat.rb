class Code
  class Parser
    class Splat < ::Code::Parser
      def parse
        previous_cursor = cursor

        if operator = match([AMPERSAND, ASTERISK + ASTERISK, ASTERISK])
          comments = parse_comments
          right = parse_next
          if right
            {
              splat: {
                right: right,
                operator: operator,
                comments: comments
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            parse_next
          end
        else
          parse_next
        end
      end

      private

      def parse_next
        parse_subclass(::Code::Parser::Function)
      end
    end
  end
end
