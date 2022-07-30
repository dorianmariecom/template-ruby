class Code
  class Parser
    class GreaterThan < Parslet::Parser
      rule(:bitwise_or) { ::Code::Parser::BitwiseOr.new }

      rule(:right_caret) { str(">") }
      rule(:left_caret) { str("<") }
      rule(:equal) { str("=") }

      rule(:operator) do
        (right_caret >> equal) |
          (left_caret >> equal) |
          right_caret |
          left_caret
      end

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:greater_than) do
        (
          bitwise_or.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                bitwise_or.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:greater_than) | bitwise_or
      end

      root(:greater_than)
    end
  end
end
