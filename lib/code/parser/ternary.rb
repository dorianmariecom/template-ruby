class Code
  class Parser
    class Ternary < Language
      def statement
        ::Code::Parser::Range
      end

      def ternary
        ::Code::Parser::Ternary
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def question_mark
        str("?")
      end

      def colon
        str(":")
      end

      def root
        (
          statement.aka(:left) <<
            (
              whitespace? << question_mark << whitespace? <<
                ternary.aka(:middle) <<
                (
                  whitespace? << colon << whitespace? << ternary.aka(:right)
                ).maybe
            ).maybe
        )
          .aka(:ternary)
          .then do |output|
            output[:ternary][:middle] ? output : output[:ternary][:left]
          end
      end
    end
  end
end
