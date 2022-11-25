class Code
  class Parser
    class Multiplication < Operation
      def statement
        ::Code::Parser::UnaryMinus
      end

      def asterisk
        str("*")
      end

      def slash
        str("/")
      end

      def percent
        str("%")
      end

      def operator
        asterisk | slash | percent
      end
    end
  end
end
