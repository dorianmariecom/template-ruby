class Code
  class Parser
    class String < ::Code::Parser
      def parse
        if match(SINGLE_QUOTE)
          parse_string(SINGLE_QUOTE)
        elsif match(DOUBLE_QUOTE)
          parse_string(DOUBLE_QUOTE)
        elsif match(COLON) && !next?(SPECIAL)
          buffer!
          consume while !next?(SPECIAL) && !end_of_input?
          match(QUESTION_MARK) || match(EXCLAMATION_POINT)
          { string: buffer }
        else
          parse_subclass(::Code::Parser::Number)
        end
      end

      private

      def parse_string(quote)
        buffer!
        output = []

        while !next?(quote) && !end_of_input?
          c = consume

          if c == BACKSLASH
            match(OPENING_CURLY_BRACKET) || match(quote)
          elsif c == OPENING_CURLY_BRACKET
            output << { text: escape_string(buffer![..-2]) } if buffer?

            output << { code: parse_code }

            match(CLOSING_CURLY_BRACKET)
            buffer!
          end
        end

        output << { text: escape_string(buffer) } if buffer?

        match(quote)

        if output.empty?
          { string: EMPTY_STRING }
        elsif output.one? && output.first.key?(:text)
          { string: output.first[:text] }
        else
          { string: output }
        end
      end

      def escape_string(string)
        string
          .gsub(SPECIAL_NEWLINE, SPECIAL_NEWLINE_ESCAPED)
          .gsub(BACKSLASH + OPENING_CURLY_BRACKET, OPENING_CURLY_BRACKET)
          .gsub(BACKSLASH + SINGLE_QUOTE, SINGLE_QUOTE)
          .gsub(BACKSLASH + DOUBLE_QUOTE, DOUBLE_QUOTE)
      end
    end
  end
end
