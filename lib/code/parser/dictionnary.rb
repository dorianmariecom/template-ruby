class Code
  class Parser
    class Dictionnary < Language
      def code
        ::Code::Parser::Code.new.present
      end

      def statement
        ::Code::Parser::Statement
      end

      def name
        ::Code::Parser::Name
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def comma
        str(",")
      end

      def colon
        str(":")
      end

      def equal
        str("=")
      end

      def greater
        str(">")
      end

      def key_value
        (name.aka(:name) << colon << code.aka(:value)) |
          (statement.aka(:statement) << colon << code.aka(:value)) |
          (
            statement.aka(
              :statement,
            ) << whitespace? << equal << greater << code.aka(:value)
          )
      end

      def root
        (
          opening_curly_bracket.ignore << whitespace? << key_value.repeat(
            0,
            1,
          ) << (
            whitespace? << comma << whitespace? << key_value
          ).repeat << whitespace? << closing_curly_bracket.ignore.maybe
        ).aka(:dictionnary) | ::Code::Parser::List
      end
    end
  end
end
