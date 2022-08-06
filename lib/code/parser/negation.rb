class Code
  class Parser
    class Negation < Parslet::Parser
      rule(:function) { ::Code::Parser::Function.new }

      rule(:exclamation_point) { str("!") }
      rule(:plus) { str("+") }

      rule(:operator) { exclamation_point | plus }

      rule(:negation) do
        (operator.as(:operator) >> negation.as(:statement)).as(:negation) |
          function
      end

      root(:negation)
    end
  end
end
