class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:statement) { ::Code::Parser::OrKeyword.new }
      root(:statement)
    end
  end
end
