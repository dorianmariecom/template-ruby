class Code
  class Parser
    class AndOperator < Operation
      def statement
        ::Code::Parser::Greater
      end

      def ampersand
        str("&")
      end

      def operator
        ampersand << ampersand
      end
    end
  end
end
