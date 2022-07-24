class Code
  class Parser
    class Code < Parslet::Parser
      rule(:statement) { ::Code::Parser::Statement.new }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:code) do
        (whitespace? >> statement >> whitespace?).repeat(1) | whitespace?
      end

      root(:code)
    end
  end
end
