class Code
  class Parser
    class EqualityLower < Equality
      def statement
        ::Code::Parser::Greater
      end
    end
  end
end
