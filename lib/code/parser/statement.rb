class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:unary) { ::Code::Parser::Unary.new }

      rule(:statement) { unary }

      root(:statement)
    end
  end
end
