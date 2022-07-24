class Code
  class Parser
    class Boolean < Parslet::Parser
      rule(:nothing) { ::Code::Parser::Nothing.new }

      rule(:true_keyword) { str("true") }
      rule(:false_keyword) { str("false") }

      rule(:boolean) { (true_keyword | false_keyword).as(:boolean) | nothing }

      root(:boolean)
    end
  end
end
