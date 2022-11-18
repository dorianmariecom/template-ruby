class Code
  class Parser
    class Dictionnary < ::Code::Parser
      def parse
        if match(OPENING_CURLY_BRACKET)
          dictionnary = []

          comments = parse_comments

          dictionnary << (
            parse_colon_key_value || parse_rocket_key_value ||
              parse_statement_key_value
          )

          while match(COMMA) && !end_of_input?
            dictionnary << (
              parse_colon_key_value || parse_rocket_key_value ||
                parse_statement_key_value
            )
          end

          match(CLOSING_CURLY_BRACKET)

          { dictionnary: dictionnary.compact, comments: comments }.compact
        else
          parse_subclass(::Code::Parser::List)
        end
      end

      private

      def parse_colon_key_value
        previous_cursor = cursor

        comments_before = parse_comments

        name = parse_subclass(::Code::Parser::Name)

        if !name
          name = parse_subclass(::Code::Parser::String)
        end

        comments_after = parse_comments

        if name && match(COLON)
          value = parse_code

          {
            name: name,
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

      def parse_rocket_key_value
        previous_cursor = cursor

        comments_before = parse_comments

        key = parse_subclass(::Code::Parser::Statement)

        comments_after = parse_comments

        if key && match(EQUAL + GREATER)
          value = parse_code

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

      def parse_statement_key_value
        previous_cursor = cursor

        comments_before = parse_comments

        statement = parse_subclass(::Code::Parser::Statement)

        comments_after = parse_comments

        if statement
          {
            statement: statement,
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
