class Code
  class Parser
    class UnaryMinus < Parslet::Parser
      rule(:power) { ::Code::Parser::Power.new }
      rule(:code) { ::Code::Parser::Code.new }

      rule(:minus) { str("-") }

      rule(:unary_minus) do
        (
          minus >> code
        ).as(:unary_minus) | power
      end

      root(:unary_minus)
    end
  end
end
