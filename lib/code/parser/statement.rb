class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:equality) { ::Code::Parser::Equality.new }

      rule(:statement) { equality }

      root(:statement)
    end
  end
end
