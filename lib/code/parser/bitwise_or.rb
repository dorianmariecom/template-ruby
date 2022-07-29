class Code
  class Parser
    class BitwiseOr < Parslet::Parser
      rule(:bitwise_and) { ::Code::Parser::BitwiseAnd.new }

      rule(:pipe) { str("|") }
      rule(:caret) { str("^") }

      rule(:operator) { pipe | caret }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:bitwise_or) do
        (
          bitwise_and.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                bitwise_and.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:bitwise_or) | bitwise_and
      end

      root(:bitwise_or)
    end
  end
end
