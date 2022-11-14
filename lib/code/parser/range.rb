class Code
  class Parser
    class Range < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [DOT + DOT + DOT, DOT + DOT],
          subclass: ::Code::Parser::OrOperator
        )
      end
    end
  end
end
