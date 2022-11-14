class Code
  class Parser
    class Dictionnary < ::Code::Parser
      def parse
        if match(OPENING_CURLY_BRACKET)
          dictionnary = []

          comments = parse_comments

          dictionnary << parse_key_value

          dictionnary << parse_key_value while match(COMMA) && !end_of_input?

          match(CLOSING_CURLY_BRACKET)

          { dictionnary: dictionnary.compact, comments: comments }.compact
        else
          parse_subclass(::Code::Parser::List)
        end
      end

      def parse_key_value
        previous_cursor = cursor

        comments_before = parse_comments

        key = parse_subclass(::Code::Parser::Statement)

        comments_after = parse_comments

        if key
          if match(COLON) || match(EQUAL + GREATER)
            value = parse_code
          else
            value = nil
          end

          {
            key: key,
            value: value,
            comments_before: comments_before,
            comments_after: comments_after
          }.compact
        else
          @cursor = previous_cursor
          buffer!
          return
        end
      end
    end
  end
end
