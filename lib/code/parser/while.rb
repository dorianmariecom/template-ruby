class Code
  class Parser
    class While < Parslet::Parser
      rule(:if_rule) { ::Code::Parser::If.new }
      rule(:code) { ::Code::Parser::Code.new }

      rule(:while_keyword) { str("while") }
      rule(:until_keyword) { str("until") }
      rule(:end_keyword) { str("end") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }

      rule(:while_rule) do
        (
          (while_keyword | until_keyword).as(:operator) >> whitespace >>
            if_rule.as(:statement) >> code.as(:body) >> end_keyword
        ).as(:while) | if_rule
      end

      root(:while_rule)
    end
  end
end
