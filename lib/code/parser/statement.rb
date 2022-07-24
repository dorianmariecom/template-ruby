class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:call) { ::Code::Parser::Call.new }

      rule(:statement) { call }

      root(:statement)
    end
  end
end
