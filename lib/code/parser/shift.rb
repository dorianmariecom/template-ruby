class Code
  class Parser
    class Shift < Operation
      def statement
        ::Code::Parser::Addition
      end

      def greater
        str(">")
      end

      def lesser
        str("<")
      end

      def operator
        (greater << greater) | (lesser << lesser)
      end
    end
  end
end
