class Code
  class Parser
    class Equality < Parslet::Parser
      rule(:while_parser) { ::Code::Parser::While.new }

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
          while_parser.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                while_parser.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:equality) | while_parser
      end

      root(:equality)
    end
  end
end
