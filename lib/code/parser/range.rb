class Code
  class Parser
    class Range < Parslet::Parser
      rule(:or_operator) { ::Code::Parser::OrOperator.new }

      rule(:dot) { str(".") }

      rule(:operator) { dot >> dot >> dot | dot >> dot }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:range) do
        (
          or_operator.as(:left) >> whitespace? >> operator.as(:operator) >>
            whitespace? >> range.as(:right)
        ).as(:range) | or_operator
      end

      root(:range)
    end
  end
end
