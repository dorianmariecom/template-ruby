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
            ).repeat(0).aka(:others)
        )
          .aka(:operation)
          .then do |output|
            if output[:operation][:others].empty?
              output[:operation][:first]
            else
              output
            end
          end
      end
    end
  end
end
