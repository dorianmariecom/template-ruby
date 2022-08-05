class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::Defined.new }
      root(:statement)
    end
  end
end
