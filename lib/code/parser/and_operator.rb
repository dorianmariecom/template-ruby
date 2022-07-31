class Code
  class Parser
    class AndOperator < Parslet::Parser
      rule(:equality) { ::Code::Parser::Equality.new }

      rule(:ampersand) { str("&") }

      rule(:operator) { ampersand >> ampersand }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:and_operator) do
        (
          equality.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                equality.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:and_operator) | equality
      end

      root(:and_operator)
    end
  end
end
