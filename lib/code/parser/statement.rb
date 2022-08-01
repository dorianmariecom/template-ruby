class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::Equal.new }
      root(:statement)
    end
  end
end
