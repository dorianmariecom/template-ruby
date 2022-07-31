class Code
  class Parser
    class Equality < Parslet::Parser
      rule(:greater_than) { ::Code::Parser::GreaterThan.new }

      rule(:right_caret) { str(">") }
      rule(:left_caret) { str("<") }
      rule(:equal) { str("=") }
      rule(:exclamation_point) { str("!") }
      rule(:tilde) { str("~") }

      rule(:operator) do
        (left_caret >> equal >> right_caret) | (equal >> equal >> equal) |
          (equal >> equal) | (exclamation_point >> equal) | (equal >> tilde) |
          (exclamation_point >> tilde)
      end

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:equality) do
        (
          greater_than.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                greater_than.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:equality) | greater_than
      end

      root(:equality)
    end
  end
end
