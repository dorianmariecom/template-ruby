class Code
  class Parser
    class OrOperator < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [PIPE + PIPE],
          subclass: ::Code::Parser::AndOperator
        )
      end
    end
  end
end
