# frozen_string_literal: true

class Template
  class Parser
    class Template < Language
      def code
        ::Code::Parser::Code
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def backslash
        str('\\')
      end

      def code_part
        opening_curly_bracket << code << (closing_curly_bracket | any.absent)
      end

      def text_character
        (backslash.ignore << opening_curly_bracket) |
          (opening_curly_bracket.absent << any)
      end

      def text_part
        text_character.repeat(1)
      end

      def root
        (code_part.aka(:code) | text_part.aka(:text)).repeat |
          str("").aka(:text).repeat(1, 1)
      end
    end
  end
end
