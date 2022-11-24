class Code
  class Parser
    class Code < Language
      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?(&block)
        whitespace.maybe(&block)
      end

      def statement
        ::Code::Parser::Statement
      end

      def present
        (whitespace? << statement << whitespace?).repeat(1)
      end

      def root
        present | whitespace?.then { [] }
      end
    end
  end
end
