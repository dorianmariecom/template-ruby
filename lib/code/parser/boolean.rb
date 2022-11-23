class Code
  class Parser
    class Boolean < Language
      def true_keyword
        str("true")
      end

      def false_keyword
        str("false")
      end

      def root
        (true_keyword | false_keyword).aka(:boolean) | ::Code::Parser::Nothing
      end
    end
  end
end
