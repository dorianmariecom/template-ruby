class Code
  class Parser
    class NotKeyword < Language
      def not_class
        ::Code::Parser::NotKeyword
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def not_keyword
        str("not")
      end

      def root
        (not_keyword.aka(:operator) << whitespace << not_class.aka(:right)).aka(
          :not
        ) | ::Code::Parser::Equal
      end
    end
  end
end
