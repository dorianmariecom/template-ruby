class Code
  class Parser
    class OrOperator < Operation
      def statement
        ::Code::Parser::AndOperator
      end

      def pipe
        str("|")
      end

      def operator
        pipe << pipe
      end
    end
  end
end
