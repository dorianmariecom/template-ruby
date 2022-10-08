class Code
  class Parser
    class Code < Parslet::Parser
      rule(:statement) { ::Code::Parser::Statement.new }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:present) do
        (whitespace?.ignore >> statement >> whitespace?.ignore).repeat(1)
      end
      rule(:code) { present | whitespace?.ignore }
      root(:code)
    end
  end
end
