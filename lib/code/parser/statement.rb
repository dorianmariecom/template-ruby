class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:power) { ::Code::Parser::Power.new }

      rule(:statement) { power }

      root(:statement)
    end
  end
end
