class Template
  class Parser
    class Template < Parslet::Parser
      rule(:code) { ::Code::Parser::Code.new }

      rule(:left_curly_bracket) { str("{") }
      rule(:right_curly_bracket) { str("}") }
      rule(:escape) { str("\\") }

      rule(:text_part) do
        (
          (escape.ignore >> left_curly_bracket) |
            (left_curly_bracket.absent? >> any)
        ).repeat(1)
      end

      rule(:code_part) do
        left_curly_bracket.ignore >> code >> (right_curly_bracket.ignore | any.absent?)
      end

      rule(:template) { (text_part.as(:text) | code_part.as(:code)).repeat(1) }

      root(:template)
    end
  end
end
