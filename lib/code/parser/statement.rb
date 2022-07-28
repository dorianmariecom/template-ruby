class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:unary_minus) { ::Code::Parser::UnaryMinus.new }

      rule(:statement) { unary_minus }

      root(:statement)
    end
  end
end
