class Code
  class Parser
    class Equal < Parslet::Parser
      rule(:rescue_rule) { ::Code::Parser::Rescue.new }
      rule(:name) { ::Code::Parser::Name.new }

      rule(:equal) { str("=") }
      rule(:plus) { str("+") }
      rule(:minus) { str("-") }
      rule(:asterisk) { str("*") }
      rule(:slash) { str("/") }
      rule(:percent) { str("%") }
      rule(:left_caret) { str("<") }
      rule(:right_caret) { str(">") }
      rule(:ampersand) { str("&") }
      rule(:pipe) { str("|") }
      rule(:caret) { str("^") }

      rule(:operator) do
        equal | (plus >> equal) | (minus >> equal) | (asterisk >> equal) |
          (slash >> equal) | (percent >> equal) |
          (left_caret >> left_caret >> equal) |
          (right_caret >> right_caret >> equal) | (ampersand >> equal) |
          (pipe >> equal) | (caret >> equal)
      end

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:equal_rule) do
        (
          name.as(:left) >> whitespace? >> operator.as(:operator) >>
            whitespace? >> rescue_rule.as(:right)
        ).as(:equal) | rescue_rule
      end

      root(:equal_rule)
    end
  end
end
