class Code
  class Parser
    class BitwiseAnd < Parslet::Parser
      rule(:shift) { ::Code::Parser::Shift.new }

      rule(:ampersand) { str("&") }

      rule(:operator) { ampersand }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:bitwise_and) do
        (
          shift.repeat(1, 1) >>
            (whitespace? >> operator >> whitespace? >> shift).repeat(1)
        ).as(:bitwise_and) | shift
      end

      root(:bitwise_and)
    end
  end
end
