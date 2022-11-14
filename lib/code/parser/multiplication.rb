class Code
  class Parser
    class Multiplication < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [ASTERISK, SLASH, PERCENT],
          subclass: ::Code::Parser::UnaryMinus
        )
      end
    end
  end
end
