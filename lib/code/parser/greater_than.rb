class Code
  class Parser
    class GreaterThan < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [GREATER + EQUAL, LESSER + EQUAL, GREATER, LESSER],
          subclass: ::Code::Parser::BitwiseOr
        )
      end
    end
  end
end
