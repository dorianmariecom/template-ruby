class Code
  class Parser
    class Multiplication < Parslet::Parser
      rule(:unary_minus) { ::Code::Parser::UnaryMinus.new }

      rule(:asterisk) { str("*") }
      rule(:slash) { str("/") }
      rule(:percent) { str("%") }

      rule(:operator) { asterisk | slash | percent }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:multiplication) do
        (
          unary_minus.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                unary_minus.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:multiplication) | unary_minus
      end

      root(:multiplication)
    end
  end
end
