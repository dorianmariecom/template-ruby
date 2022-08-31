class Code
  class Parser
    class Code < Parslet::Parser
      rule(:statement) { ::Code::Parser::Statement.new }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:code) do
        (whitespace?.ignore >> statement >> whitespace?.ignore).repeat(1) | whitespace?.ignore
      end

      root(:code)
    end
  end
end
