class Code
  class Parser
    class Negation < Parslet::Parser
      rule(:call) { ::Code::Parser::Call.new }

      rule(:exclamation_point) { str("!") }
      rule(:plus) { str("+") }

      rule(:operator) { exclamation_point | plus }

      rule(:negation) do
        (operator.as(:operator) >> negation.as(:statement)).as(:negation) | call
      end

      root(:negation)
    end
  end
end
