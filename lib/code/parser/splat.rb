class Code
  class Parser
    class Splat < Language
      def statement
        ::Code::Parser::Class
      end

      def splat
        ::Code::Parser::Splat
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def ampersand
        str("&")
      end

      def root
        (ampersand.aka(:operator) << whitespace? << splat.aka(:right)).aka(
          :splat
        ) | statement
      end
    end
  end
end
