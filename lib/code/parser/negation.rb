class Code
  class Parser
    class Negation < Language
      def exclamation_point
        str("!")
      end

      def tilde
        str("~")
      end

      def plus
        str("+")
      end

      def operator
        exclamation_point | tilde | plus
      end

      def negation
        ::Code::Parser::Negation
      end

      def root
        (operator.aka(:operator) << negation.aka(:right)).aka(:negation) |
          ::Code::Parser::Function
      end
    end
  end
end
