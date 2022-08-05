class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::While.new }
      root(:statement)
    end
  end
end
