class Code
  class Parser
    class Addition < Parslet::Parser
      rule(:multiplication) { ::Code::Parser::Multiplication.new }

      rule(:plus) { str("+") }
      rule(:minus) { str("-") }

      rule(:operator) { plus | minus }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:addition) do
        (
          multiplication.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                multiplication.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:addition) | multiplication
      end

      root(:addition)
    end
  end
end
