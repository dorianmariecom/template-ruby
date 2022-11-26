class Code
  class Parser
    class IfModifier < Language
      def statement
        ::Code::Parser::OrKeyword
      end

      def if_modifier
        ::Code::Parser::IfModifier
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def whitespace_without_newline?
        ::Code::Parser::Whitespace.new.without_newline.maybe
      end

      def if_keyword
        str("if")
      end

      def unless_keyword
        str("unless")
      end

      def while_keyword
        str("while")
      end

      def until_keyword
        str("until")
      end

      def operator
        if_keyword | unless_keyword | while_keyword | until_keyword
      end

      def root
        (
          statement.aka(:left) <<
            (
              whitespace_without_newline? << operator.aka(:operator) <<
                whitespace? << if_modifier.aka(:right)
            ).maybe
        )
          .aka(:if_modifier)
          .then do |output|
            output[:if_modifier][:right] ? output : output[:if_modifier][:left]
          end
      end
    end
  end
end
