class Code
  class Parser
    class Unary < Parslet::Parser
      rule(:call) { ::Code::Parser::Call.new }

      rule(:exclamation_point) { str("!") }
      rule(:plus) { str("+") }

      rule(:operator) { exclamation_point | plus }

      rule(:unary) do
        (operator.as(:operator) >> unary.as(:expression)).as(:unary) | call
      end

      root(:unary)
    end
  end
end
