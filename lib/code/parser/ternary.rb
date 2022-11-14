class Code
  class Parser
    class Ternary < ::Code::Parser
      def parse
        left = parse_subclass(::Code::Parser::Range)

        previous_cursor = cursor
        return left if !match(WHITESPACE) && !(first_comments = parse_comments)
        first_comments ||= parse_comments

        if match(QUESTION_MARK)
          second_comments = parse_comments

          middle = parse_subclass(::Code::Parser::Ternary)

          if middle
            previous_cursor = cursor
            third_comments = parse_comments

            if match(COLON)
              fourth_comments = parse_comments
              right = parse_subclass(::Code::Parser::Ternary)

              if right
                {
                  ternary: {
                    left: left,
                    middle: middle,
                    right: right,
                    first_comments: first_comments,
                    second_comments: second_comments,
                    third_comments: third_comments,
                    fourth_comments: fourth_comments
                  }.compact
                }
              else
                @cursor = previous_cursor
                buffer!
                {
                  ternary: {
                    left: left,
                    middle: middle,
                    first_comments: first_comments,
                    second_comments: second_comments
                  }.compact
                }
              end
            else
              @cursor = previous_cursor
              buffer!
              {
                ternary: {
                  left: left,
                  middle: middle,
                  first_comments: first_comments,
                  second_comments: second_comments
                }.compact
              }
            end
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
