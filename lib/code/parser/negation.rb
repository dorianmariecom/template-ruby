class Code
  class Parser
    class Negation < ::Code::Parser
      def parse
        if operator = match([EXCLAMATION_POINT, TILDE, PLUS])
          {
            negation: {
              operator: operator,
              statement: parse_subclass(::Code::Parser::Negation)
            }
          }
        else
          parse_subclass(::Code::Parser::Splat)
        end
      end
    end
  end
end
