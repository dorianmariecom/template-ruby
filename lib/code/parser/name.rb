class Code
  class Parser
    class Name < Language
      def space
        str(" ")
      end

      def newline
        str("\n")
      end

      def comma
        str(",")
      end

      def equal
        str("=")
      end

      def colon
        str(":")
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def opening_square_bracket
        str("[")
      end

      def closing_square_bracket
        str("]")
      end

      def opening_parenthesis
        str("(")
      end

      def closing_parenthesis
        str(")")
      end

      def single_quote
        str("'")
      end

      def double_quote
        str('"')
      end

      def dot
        str(".")
      end

      def pipe
        str("|")
      end

      def ampersand
        str("&")
      end

      def do_keyword
        str("do")
      end

      def end_keyword
        str("end")
      end

      def special_character
        ampersand | equal | pipe | dot | colon | comma | space | newline |
          opening_curly_bracket | closing_curly_bracket | opening_parenthesis |
          closing_parenthesis | opening_square_bracket |
          closing_square_bracket | single_quote | double_quote
      end

      def character
        special_character.absent << any
      end

      def root
        do_keyword.absent << end_keyword.absent << character.repeat(1)
      end
    end
  end
end
