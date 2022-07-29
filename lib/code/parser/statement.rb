class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:bitwise_or) { ::Code::Parser::BitwiseOr.new }

      rule(:statement) { bitwise_or }

      root(:statement)
    end
  end
end
