class Code
  class Parser
    class Nothing < ::Code::Parser
      def parse
        if match(NOTHING_KEYWORDS)
          { nothing: buffer }
        else
          parse_subclass(::Code::Parser::Group)
        end
      end
    end
  end
end
