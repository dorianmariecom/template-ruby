class Code
  class Parser
    class AndOperator < Parslet::Parser
      rule(:greater_than) { ::Code::Parser::GreaterThan.new }

      rule(:ampersand) { str("&") }

      rule(:operator) { ampersand >> ampersand }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:and_operator) do
        (
          greater_than.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                greater_than.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:and_operator) | greater_than
      end

      root(:and_operator)
    end
  end
end
