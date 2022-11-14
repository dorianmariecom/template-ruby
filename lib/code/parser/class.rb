class Code
  class Parser
    class Class < ::Code::Parser
      def parse
        previous_cursor = cursor

        if match(CLASS_KEYWORD)
          first_comments = parse_comments

          name = parse_subclass(::Code::Parser::Name)

          if name
            second_comments = parse_comments

            if match(LESSER)
              previous_cursor = cursor
              third_comments = parse_comments
              superclass = parse_subclass(::Code::Parser::Name)

              if !superclass
                @cursor = previous_cursor
                buffer!
                third_comments = nil
              end
            else
              third_comments = nil
              superclass = nil
            end

            body = parse_code

            match(END_KEYWORD)

            {
              class: {
                name: name,
                superclass: superclass,
                first_comments: first_comments,
                second_comments: second_comments,
                third_comments: third_comments,
                body: body
              }.compact
            }
          else
            @cursor = previous_cursor
            buffer!
            parse_subclass(::Code::Parser::While)
          end
        else
          parse_subclass(::Code::Parser::While)
        end
      end
    end
  end
end
