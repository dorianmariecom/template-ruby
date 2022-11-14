class Code
  class Parser
    class BitwiseOr < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [PIPE, CARET],
          subclass: ::Code::Parser::BitwiseAnd
        )
      end
    end
  end
end
