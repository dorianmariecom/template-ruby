class Code
  class Parser
    class Group < ::Code::Parser
      def parse
        if match(OPENING_PARENTHESIS)
          code = parse_subclass(::Code::Parser::Code)
          match(CLOSING_PARENTHESIS)
          { group: code }
        else
          parse_subclass(::Code::Parser::Call)
        end
      end
    end
  end
end
