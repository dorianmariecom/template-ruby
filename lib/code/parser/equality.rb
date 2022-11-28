class Code
  class Parser
    class Equality < Operation
      def statement
        ::Code::Parser::While
      end

      def equal
        str("=")
      end

      def greater
        str(">")
      end

      def lesser
        str("<")
      end

      def exclamation_point
        str("!")
      end

      def tilde
        str("~")
      end

      def operator
        (equal << equal << equal) | (equal << equal) |
          (lesser << equal << greater) | (exclamation_point << equal) |
          (equal << tilde) | (tilde << equal) | (exclamation_point << tilde)
      end
    end
  end
end
