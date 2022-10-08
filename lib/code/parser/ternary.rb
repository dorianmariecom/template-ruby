class Code
  class Parser
    class Ternary < Parslet::Parser
      rule(:defined) { ::Code::Parser::Defined.new }

      rule(:question_mark) { str("?") }
      rule(:colon) { str(":") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:ternary) do
        (
          defined.as(:left) >> whitespace >> question_mark >> whitespace? >>
            ternary.as(:middle) >>
            (whitespace? >> colon >> whitespace? >> ternary.as(:right)).maybe
        ).as(:ternary) | defined
      end

      root(:ternary)
    end
  end
end
