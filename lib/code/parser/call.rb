class Code
  class Parser
    class Call < Parslet::Parser
      rule(:dictionnary) { ::Code::Parser::Dictionnary.new }

      rule(:dot) { str(".") }

      rule(:call) do
        (dictionnary.as(:left) >> dot >> call.as(:right)).as(:call) |
          dictionnary
      end

      root(:call)
    end
  end
end
