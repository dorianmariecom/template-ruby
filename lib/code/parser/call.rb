class Code
  class Parser
    class Call < Parslet::Parser
      rule(:string) { ::Code::Parser::String.new }

      rule(:dot) { str(".") }

      rule(:call) do
        (string.as(:left) >> dot >> call.as(:right)).as(:call) | string
      end

      root(:call)
    end
  end
end
