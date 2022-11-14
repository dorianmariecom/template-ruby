class Code
  class Parser
    class ChainedCall < ::Code::Parser
      def parse
        left = parse_dictionnary
        previous_cursor = cursor
        comments_before = parse_comments

        if left && match([DOT, COLON + COLON])
          comments_after = parse_comments
          right = parse_dictionnary
          if right
            chained_call = [{ left: left, right: right }]
            while match([DOT, COLON + COLON]) && other_right = parse_dictionnary
              chained_call << { right: other_right }
            end
            {
              chained_call: {
                calls: chained_call,
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

      def parse_dictionnary
        parse_subclass(::Code::Parser::Dictionnary)
      end
    end
  end
end
