class Code
  class Parser
    class NotKeyword < Parslet::Parser
      rule(:defined) { ::Code::Parser::Defined.new }

      rule(:not_keyword) { str("not") }

      rule(:operator) { not_keyword }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }

      rule(:not_rule) do
        (
          not_keyword >> whitespace >> not_rule
        ).as(:not_keyword) | defined
      end

      root(:not_rule)
    end
  end
end
