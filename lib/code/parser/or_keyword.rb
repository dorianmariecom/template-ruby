class Code
  class Parser
    class OrKeyword < Operation
      def statement
        ::Code::Parser::NotKeyword
      end

      def or_keyword
        str("or")
      end

      def and_keyword
        str("and")
      end

      def operator
        or_keyword | and_keyword
      end
    end
  end
end
