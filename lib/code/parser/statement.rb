class Code
  class Parser
    class Statement < Parslet::Parser
      rule(:shift) { ::Code::Parser::Shift.new }

      rule(:statement) { shift }

      root(:statement)
    end
  end
end
