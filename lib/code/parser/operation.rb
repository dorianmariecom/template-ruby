class Code
  class Parser
    class Operation < Language
      def statement
        raise NotImplementedError
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def operator
        raise NotImplementedError
      end

      def root
        (
          statement.aka(:first) <<
            (
              whitespace? << operator.aka(:operator) << whitespace? <<
                statement.aka(:statement)
            ).repeat(1).aka(:others).maybe
        )
          .aka(:operation)
          .then do |output|
            output[:operation][:others] ? output : output[:operation][:first]
          end
      end
    end
  end
end
