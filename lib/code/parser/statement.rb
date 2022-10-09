class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::Equality.new }
      root(:statement)
    end
  end
end
