class Code
  class Parser
    class Rescue < Parslet::Parser
      rule(:ternary) { ::Code::Parser::Ternary.new }

      rule(:rescue_keyword) { str("rescue") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:rescue) do
        (
          ternary.as(:left) >> whitespace? >> rescue_keyword >> whitespace? >> ternary.as(:right)
        ).as(:rescue) | ternary
      end

      root(:rescue)
    end
  end
end
