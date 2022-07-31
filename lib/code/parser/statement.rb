class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::Rescue.new }
      root(:statement)
    end
  end
end
