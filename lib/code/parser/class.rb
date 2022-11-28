class Code
  class Parser
    class Class < Language
      def statement
        ::Code::Parser::While
      end

      def name
        ::Code::Parser::Name
      end

      def code
        ::Code::Parser::Code
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def class_keyword
        str("class")
      end

      def end_keyword
        str("end")
      end

      def lesser
        str("<")
      end

      def root
        (
          class_keyword << whitespace? << name.aka(:name) <<
          (whitespace? << lesser << name.aka(:superclass)).maybe <<
          code.aka(:body) << end_keyword.maybe
        ).aka(:class) | statement
      end
    end
  end
end
