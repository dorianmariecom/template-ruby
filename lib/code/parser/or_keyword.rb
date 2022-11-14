class Code
  class Parser
    class OrKeyword < ::Code::Parser
      def parse
        parse_subclass(
          ::Code::Parser::Operation,
          operators: [AND_KEYWORD, OR_KEYWORD],
          subclass: ::Code::Parser::NotKeyword
        )
      end
    end
  end
end
