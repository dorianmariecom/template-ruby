class Code
  class Parser
    class Power < Language
      def power
        ::Code::Parser::Power
      end

      def statement
        ::Code::Parser::Negation
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def asterisk
        str("*")
      end

      def operator
        asterisk << asterisk
      end

      def root
        (
          statement.aka(:left) <<
            (
              whitespace? << operator.aka(:operator) << whitespace? <<
                power.aka(:right)
            ).maybe
        )
          .aka(:power)
          .then do |output|
            output[:power][:right] ? output : output[:power][:left]
          end
      end
    end
  end
end
