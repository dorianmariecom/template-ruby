class Code
  class Parser
    class ChainedCall < Operation
      def statement
        ::Code::Parser::Dictionnary
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def dot
        str(".")
      end

      def colon
        str(":")
      end

      def operator
        dot | (colon << colon)
      end

      def root
        (
          statement.aka(:first) <<
            (whitespace? << operator << whitespace? << statement)
              .repeat(1)
              .aka(:others)
              .maybe
        )
          .aka(:chained_call)
          .then do |output|
            if output[:chained_call][:others]
              output
            else
              output[:chained_call][:first]
            end
          end
      end
    end
  end
end
