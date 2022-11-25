class Code
  class Parser
    class Range < Operation
      def statement
        ::Code::Parser::OrOperator
      end

      def dot
        str(".")
      end

      def operator
        (dot << dot << dot) | (dot << dot)
      end
    end
  end
end
