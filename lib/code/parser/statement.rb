class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:range) { ::Code::Parser::Range.new }

      rule(:statement) { range }

      root(:statement)
    end
  end
end
