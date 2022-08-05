class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::If.new }
      root(:statement)
    end
  end
end
