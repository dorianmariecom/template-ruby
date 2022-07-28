class Code
  class Parser
    class Power < Parslet::Parser
      rule(:negation) { ::Code::Parser::Negation.new }

      rule(:asterisk) { str("*") }

      rule(:operator) { asterisk >> asterisk }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:power) do
        (
          negation.as(:left) >> whitespace? >> operator >> whitespace? >>
            power.as(:right)
        ).as(:power) | negation
      end

      root(:power)
    end
  end
end
