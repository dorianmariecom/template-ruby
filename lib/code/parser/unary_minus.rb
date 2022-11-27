class Code
  class Parser
    class UnaryMinus < Language
      def unary_minus
        ::Code::Parser::UnaryMinus
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def minus
        str("-")
      end

      def operator
        minus
      end

      def root
        (operator.aka(:operator) << whitespace? << unary_minus.aka(:right)).aka(
          :unary_minus
        ) | ::Code::Parser::Power
      end
    end
  end
end
