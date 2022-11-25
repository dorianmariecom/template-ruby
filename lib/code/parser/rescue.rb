class Code
  class Parser
    class Rescue < Language
      def statement
        ::Code::Parser::Ternary
      end

      def rescue_class
        ::Code::Parser::Rescue
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def rescue_keyword
        str("rescue")
      end

      def root
        (
          statement.aka(:left) <<
            (
              whitespace? << rescue_keyword << whitespace? <<
                rescue_class.aka(:right)
            ).maybe
        )
          .aka(:rescue)
          .then do |output|
            output[:rescue][:right] ? output : output[:rescue][:left]
          end
      end
    end
  end
end
