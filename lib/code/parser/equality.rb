class Code
  class Parser
    class Equality < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [
            EQUAL + EQUAL + EQUAL,
            LESSER + EQUAL + GREATER,
            EQUAL + TILDE,
            EXCLAMATION_POINT + TILDE,
            EQUAL + EQUAL,
            EXCLAMATION_POINT + EQUAL
          ],
          subclass: ::Code::Parser::GreaterThan
        )
      end
    end
  end
end
