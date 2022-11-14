class Code
  class Parser
    class Boolean < ::Code::Parser
      def parse
        if match(BOOLEAN_KEYWORDS)
          { boolean: buffer }
        else
          parse_subclass(::Code::Parser::Nothing)
        end
      end
    end
  end
end
