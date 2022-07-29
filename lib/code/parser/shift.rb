class Code
  class Parser
    class Shift < Parslet::Parser
      rule(:addition) { ::Code::Parser::Addition.new }

      rule(:right_caret) { str(">") }
      rule(:left_caret) { str("<") }

      rule(:operator) do
        (left_caret >> left_caret) | (right_caret >> right_caret)
      end

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:shift) do
        (
          addition.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                addition.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:shift) | addition
      end

      root(:shift)
    end
  end
end
