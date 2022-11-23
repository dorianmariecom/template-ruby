class Code
  class Parser
    class Nothing < Language
      def nothing_keyword
        str("nothing")
      end

      def null_keyword
        str("null")
      end

      def nil_keyword
        str("nil")
      end

      def root
        (nothing_keyword | null_keyword | nil_keyword).aka(:nothing) |
          ::Code::Parser::Group
      end
    end
  end
end
