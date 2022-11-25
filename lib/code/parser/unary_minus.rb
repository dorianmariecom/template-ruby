class Code
  class Parser
    class UnaryMinus < Language
      def unary_minus
        ::Code::Parser::UnaryMinus
      end

      def minus
        str("-")
      end

      def operator
        minus
      end

      def root
        (operator.aka(:operator) << unary_minus.aka(:right)).aka(:unary_minus) |
          ::Code::Parser::Power
      end
    end
  end
end
