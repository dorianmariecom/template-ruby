class Code
  class Parser
    class Code < ::Code::Parser
      def parse
        output = []

        comments = parse_comments
        output << { comments: comments } if comments

        while code = parse_subclass(::Code::Parser::Statement)
          output << code
          comments = parse_comments
          output << { comments: comments } if comments
        end

        output
      end
    end
  end
end
