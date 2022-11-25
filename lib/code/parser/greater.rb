class Code
  class Parser
    class Greater < Operation
      def statement
        ::Code::Parser::BitwiseOr
      end

      def greater
        str(">")
      end

      def lesser
        str("<")
      end

      def equal
        str("=")
      end

      def operator
        (greater << equal) | (lesser << equal) | greater | lesser
      end
    end
  end
end
