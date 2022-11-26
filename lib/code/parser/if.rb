class Code
  class Parser
    class If < Language
      def statement
        ::Code::Parser::IfModifier
      end

      def if_class
        ::Code::Parser::If
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def code
        ::Code::Parser::Code
      end

      def whitespace?
        whitespace.maybe
      end

      def if_keyword
        str("if")
      end

      def unless_keyword
        str("unless")
      end

      def elsif_keyword
        str("elsif")
      end

      def else_keyword
        str("else")
      end

      def end_keyword
        str("end")
      end

      def root
        (
          (if_keyword | unless_keyword).aka(:first_operator) << whitespace <<
            statement.aka(:first_statement) << code.aka(:first_body) <<
            (
              (
                elsif_keyword.aka(:operator) << whitespace <<
                  statement.aka(:statement) << code.aka(:body)
              ) |
                (
                  else_keyword << whitespace <<
                    (if_keyword | unless_keyword).aka(:operator) <<
                    whitespace << statement.aka(:statement) << code.aka(:body)
                ) | (else_keyword.aka(:operator) << code.aka(:body))
            ).repeat(1).aka(:elses).maybe << end_keyword.maybe
        ).aka(:if) | statement
      end
    end
  end
end
