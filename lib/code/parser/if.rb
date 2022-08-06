class Code
  class Parser
    class If < Parslet::Parser
      rule(:if_modifier) { ::Code::Parser::IfModifier.new }
      rule(:code) { ::Code::Parser::Code.new }

      rule(:if_keyword) { str("if") }
      rule(:else_keyword) { str("else") }
      rule(:unless_keyword) { str("unless") }
      rule(:end_keyword) { str("end") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }

      rule(:if_rule) do
        (
          (if_keyword | unless_keyword).as(:if_operator) >> whitespace >>
            if_modifier.as(:if_statement) >> code.as(:if_body) >>
            (
              else_keyword >>
                (
                  whitespace >> (if_keyword | unless_keyword).as(:operator) >>
                    whitespace >> if_modifier.as(:statement)
                ).maybe >> code.as(:body)
            ).repeat(1).as(:elses).maybe >> end_keyword
        ).as(:if) | if_modifier
      end

      root(:if_rule)
    end
  end
end
