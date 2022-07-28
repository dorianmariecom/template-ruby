class Code
  class Parser
    class Power < Parslet::Parser
      rule(:unary) { ::Code::Parser::Unary.new }
      rule(:code) { ::Code::Parser::Code.new }

      rule(:asterisk) { str("*") }

      rule(:operator) { asterisk >> asterisk }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:power) do
        (
          unary.as(:left) >> whitespace? >> operator >> whitespace? >>
            code.as(:right)
        ).as(:power) | unary
      end

      root(:power)
    end
  end
end
