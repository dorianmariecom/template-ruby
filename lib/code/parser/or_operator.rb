class Code
  class Parser
    class OrOperator < Parslet::Parser
      rule(:and_operator) { ::Code::Parser::AndOperator.new }

      rule(:pipe) { str("|") }

      rule(:operator) { pipe >> pipe }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:or_operator) do
        (
          and_operator.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                and_operator.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:or_operator) | and_operator
      end

      root(:or_operator)
    end
  end
end
