class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:multiplication) { ::Code::Parser::Multiplication.new }

      rule(:statement) { multiplication }

      root(:statement)
    end
  end
end
