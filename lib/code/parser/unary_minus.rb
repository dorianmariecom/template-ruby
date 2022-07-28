class Code
  class Parser
    class UnaryMinus < Parslet::Parser
      rule(:power) { ::Code::Parser::Power.new }

      rule(:minus) { str("-") }

      rule(:unary_minus) { (minus >> unary_minus).as(:unary_minus) | power }

      root(:unary_minus)
    end
  end
end
