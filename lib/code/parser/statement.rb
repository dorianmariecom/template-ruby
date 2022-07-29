class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:addition) { ::Code::Parser::Addition.new }

      rule(:statement) { addition }

      root(:statement)
    end
  end
end
