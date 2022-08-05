class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::IfModifier.new }
      root(:statement)
    end
  end
end
