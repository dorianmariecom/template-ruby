class Code
  class Parser
    class List < Language
      def code
        ::Code::Parser::Code.new.present
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def opening_square_bracket
        str("[")
      end

      def closing_square_bracket
        str("]")
      end

      def comma
        str(",")
      end

      def element
        code
      end

      def root
        (
          opening_square_bracket.ignore << whitespace? << element.repeat(
            0,
            1,
          ) << (
            whitespace? << comma << whitespace? << element
          ).repeat << whitespace? << closing_square_bracket.ignore.maybe
        ).aka(:list) | ::Code::Parser::String
      end
    end
  end
end
