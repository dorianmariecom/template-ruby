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
          shift.as(:first) >>
          (whitespace? >> operator.as(:operator) >> whitespace? >> shift.as(:statement)).repeat(1).as(:rest)
        ).as(:bitwise_and) | shift
      end

      root(:bitwise_and)
    end
  end
end
