class Code
  class Parser
    class IfModifier < Parslet::Parser
      rule(:or_keyword) { ::Code::Parser::OrKeyword.new }

      rule(:if_keyword) { str("if") }
      rule(:unless_keyword) { str("unless") }
      rule(:while_keyword) { str("while") }
      rule(:until_keyword) { str("until") }

      rule(:operator) do
        if_keyword | unless_keyword | while_keyword | until_keyword
      end

      rule(:space) { str(" ") }
      rule(:whitespace) { space.repeat(1) }

      rule(:if_modifier) do
        (
          or_keyword.as(:left) >> whitespace >> operator.as(:operator) >>
            whitespace >> if_modifier.as(:right)
        ).as(:if_modifier) | or_keyword
      end

      root(:if_modifier)
    end
  end
end
