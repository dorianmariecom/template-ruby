class Code
  class Parser
    class Addition < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [PLUS, MINUS],
          subclass: ::Code::Parser::Multiplication
        )
      end
    end
  end
end
