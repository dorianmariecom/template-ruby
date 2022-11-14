class Code
  class Parser
    class NotKeyword < ::Code::Parser
      def parse
        previous_cursor = cursor

        if match(NOT_KEYWORD)
          buffer!
          consume while next?(WHITESPACE)
          comments = parse_comments
          right = parse_subclass(::Code::Parser::NotKeyword)

          if right && (comments || buffer?)
            { not: { right: right, comments: comments }.compact }
          else
            @cursor = previous_cursor
            buffer!
            parse_subclass(::Code::Parser::Equal)
          end
        else
          parse_subclass(::Code::Parser::Equal)
        end
      end
    end
  end
end
