class Code
  class Parser
    class If < ::Code::Parser
      def parse
        if first_operator = match([IF_KEYWORD, UNLESS_KEYWORD])
          previous_cursor = cursor
          first_comments = parse_comments
          first_condition = parse_subclass(::Code::Parser::If)

          if first_condition
            first_body = parse_code

            others = []

            while (other = parse_else) || (other = parse_elsif)
              others << other
            end

            others = nil if others.empty?

            match(END_KEYWORD)

            {
              if: {
                first_operator: first_operator,
                first_comments: first_comments,
                first_condition: first_condition,
                first_body: first_body,
                others: others
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            parse_subclass(::Code::Parser::IfModifier)
          end
        else
          parse_subclass(::Code::Parser::IfModifier)
        end
      end

      private

      def parse_else
        return unless match(ELSE_KEYWORD)
        comments_before = parse_comments

        operator = match([IF_KEYWORD, UNLESS_KEYWORD]) || ELSE_KEYWORD

        comments_after = parse_comments

        if operator == ELSE_KEYWORD
          condition = nil
        else
          condition = parse_subclass(::Code::Parser::If)
        end

        body = parse_code

        {
          operator: operator,
          comments_before: comments_before,
          comments_after: comments_after,
          condition: condition,
          body: body
        }.compact
      end

      def parse_elsif
        return unless operator = match([ELSIF_KEYWORD, ELSUNLESS_KEYWORD])

        comments = parse_comments
        condition = parse_subclass(::Code::Parser::If)
        body = parse_code

        {
          operator: operator,
          comments: comments,
          condition: condition,
          body: body
        }.compact
      end
    end
  end
end
