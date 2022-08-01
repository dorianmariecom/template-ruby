class Code
  class Parser
    class Ternary < Parslet::Parser
      rule(:range) { ::Code::Parser::Range.new }

      rule(:question_mark) { str("?") }
      rule(:colon) { str(":") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:ternary) do
        (
          range.as(:left) >> whitespace >> question_mark >> whitespace? >>
            ternary.as(:middle) >>
            (whitespace? >> colon >> whitespace? >> ternary.as(:right)).maybe
        ).as(:ternary) | range
      end

      root(:ternary)
    end
  end
end
