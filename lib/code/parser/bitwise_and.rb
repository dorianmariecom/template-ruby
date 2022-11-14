class Code
  class Parser
    class BitwiseAnd < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [AMPERSAND],
          subclass: ::Code::Parser::Shift
        )
      end
    end
  end
end
