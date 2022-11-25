class Code
  class Parser
    class String < Language
      def code
        ::Code::Parser::Code
      end

      def single_quote
        str("'")
      end

      def double_quote
        str('"')
      end

      def backslash
        str("\\")
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def code_part
        opening_curly_bracket << code << closing_curly_bracket.maybe
      end

      def single_quoted_text_part
        (
          backslash.ignore << opening_curly_bracket |
            backslash.ignore << single_quote |
            single_quote.absent << opening_curly_bracket.absent << any
        ).repeat(1)
      end

      def double_quoted_text_part
        (
          backslash.ignore << opening_curly_bracket |
            backslash.ignore << double_quote |
            double_quote.absent << opening_curly_bracket.absent << any
        ).repeat(1)
      end

      def single_quoted_string
        single_quote.ignore << (
          code_part.aka(:code) | single_quoted_text_part.aka(:text)
        ).repeat << single_quote.ignore.maybe
      end

      def double_quoted_string
        double_quote.ignore << (
          code_part.aka(:code) | double_quoted_text_part.aka(:text)
        ).repeat << double_quote.ignore.maybe
      end

      def root
        (single_quoted_string | double_quoted_string).aka(:string) |
          ::Code::Parser::Number
      end
    end
  end
end
