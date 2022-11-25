class Code
  class Parser
    class BitwiseAnd < Operation
      def statement
        ::Code::Parser::Shift
      end

      def ampersand
        str("&")
      end

      def operator
        ampersand
      end
    end
  end
end
