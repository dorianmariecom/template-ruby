class Code
  class Parser
    class UnaryMinus < ::Code::Parser
      def parse
        if match(MINUS)
          previous_cursor = cursor
          comments = parse_comments
          right = parse_subclass(::Code::Parser::UnaryMinus)

          if right
            { unary_minus: { right: right, comments: comments }.compact }
          else
            @cursor = previous_cursor
            buffer!
            parse_subclass(::Code::Parser::Power)
          end
        else
          parse_subclass(::Code::Parser::Power)
        end
      end
    end
  end
end
