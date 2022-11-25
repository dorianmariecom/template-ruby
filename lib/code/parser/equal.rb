class Code
  class Parser
    class Equal < Language
      def statement
        ::Code::Parser::Rescue
      end

      def name
        ::Code::Parser::Name
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def equal
        str("=")
      end

      def plus
        str("+")
      end

      def minus
        str("-")
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

      def greater
        str(">")
      end

      def lesser
        str("<")
      end

      def ampersand
        str("&")
      end

      def pipe
        str("|")
      end

      def caret
        str("^")
      end

      def operator
        equal.ignore | (plus << equal.ignore) | (minus << equal.ignore) |
          (asterisk << equal.ignore) | (slash << equal.ignore) |
          (percent << equal.ignore) | (greater << greater << equal.ignore) |
          (lesser << lesser << equal.ignore) | (ampersand << equal.ignore) |
          (pipe << equal.ignore) | (caret << equal.ignore) |
          (pipe << pipe << equal.ignore) |
          (ampersand << ampersand << equal.ignore)
      end

      def root
        (
          name.aka(:left) << whitespace? << operator.aka(:operator) <<
            whitespace? << ::Code::Parser::Equal.aka(:right)
        ).aka(:equal) | statement
      end
    end
  end
end
