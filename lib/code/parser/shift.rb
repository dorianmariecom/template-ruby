class Code
  class Parser
    class Shift < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [GREATER + GREATER, LESSER + LESSER],
          subclass: ::Code::Parser::Addition
        )
      end
    end
  end
end
