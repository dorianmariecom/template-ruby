class Code
  class Parser
    class Call < ::Code::Parser
      def parse
        name = parse_subclass(::Code::Parser::Name)
        return unless name

        if match(OPENING_PARENTHESIS)
          arguments = []

          arguments << (parse_keyword_argument || parse_regular_argument)

          while match(COMMA) && !end_of_input?
            arguments << (parse_keyword_argument || parse_regular_argument)
          end

          arguments.compact!

          match(CLOSING_PARENTHESIS)
        else
          arguments = nil
        end

        previous_cursor = cursor
        comments = parse_comments

        if match(DO_KEYWORD)
          block = parse_block
          match(END_KEYWORD)
        elsif match(OPENING_CURLY_BRACKET)
          block = parse_block
          match(CLOSING_CURLY_BRACKET)
        else
          @cursor = previous_cursor
          buffer!
          block = nil
        end

        {
          call: {
            name: name,
            arguments: arguments,
            block: block,
            comments: comments
          }.compact
        }
      end

      private

      def parse_block
        comments = parse_comments

        if match(PIPE)
          parameters = []

          parameters << (parse_keyword_parameter || parse_regular_parameter)

          while match(COMMA) && !end_of_input?
            parameters << (parse_keyword_parameter || parse_regular_parameter)
          end

          match(PIPE)

          {
            comments: comments,
            parameters: parameters.compact,
            body: parse_code
          }.compact
        else
          { comments: comments, body: parse_code }.compact
        end
      end

      def parse_keyword_argument
        previous_cursor = cursor

        comments_before = parse_comments
        name = parse_subclass(::Code::Parser::Name)
        comments_after = parse_comments

        if name && match(COLON) || match(EQUAL + GREATER)
          value = parse_code
          {
            name: name,
            value: value,
            comments_before: comments_before,
            comments_after: comments_after,
          }.compact
        else
          @cursor = previous_cursor
          buffer!
          return
        end
      end

      def parse_regular_argument
        {
          value: parse_code
        }
      end

      def parse_keyword_parameter
        previous_cursor = cursor

        comments_before = parse_comments
        name = parse_subclass(::Code::Parser::Name)
        comments_after = parse_comments

        if name && match(COLON) || match(EQUAL + GREATER)
          default = parse_default

          {
            kind: :keyword,
            name: name,
            default: default,
            comments_before: comments_before,
            comments_after: comments_after
          }.compact
        else
          @cursor = previous_cursor
          buffer!
          return
        end
      end

      def parse_regular_parameter
        previous_cursor = cursor
        comments_before = parse_comments

        if match(AMPERSAND)
          kind = :block
        elsif match(ASTERISK + ASTERISK)
          kind = :keyword_splat
        elsif match(ASTERISK)
          kind = :regular_splat
        else
          kind = nil
        end

        name = parse_subclass(::Code::Parser::Name)

        if name
          comments_after = parse_comments

          if match(EQUAL)
            default = parse_default
          else
            default = nil
          end

          {
            comments_before: comments_before,
            comments_after: comments_after,
            default: default,
            name: name,
            kind: kind
          }.compact
        else
          @cursor = previous_cursor
          buffer!
          return
        end
      end

      def parse_default
        comments_before = parse_comments
        statement = parse_subclass(::Code::Parser::BitwiseAnd)
        comments_after = parse_comments

        default = {
          statement: statement,
          comments_before: comments_before,
          comments_after: comments_after
        }.compact

        default.empty? ? nil : default
      end
    end
  end
end
