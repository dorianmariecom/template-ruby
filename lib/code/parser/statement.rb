class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::Ternary.new }
      root(:statement)
    end
  end
end
