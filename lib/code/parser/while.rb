class Code
  class Parser
    class While < Language
      def statement
        ::Code::Parser::If
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def code
        ::Code::Parser::Code
      end

      def while_keyword
        str("while")
      end

      def until_keyword
        str("until")
      end

      def end_keyword
        str("end")
      end

      def root
        (
          (while_keyword | until_keyword).aka(:operator) << whitespace <<
            statement.aka(:statement) << code.aka(:body) << end_keyword.maybe
        ).aka(:while) | statement
      end
    end
  end
end
