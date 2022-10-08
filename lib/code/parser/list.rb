class Code
  class Parser
    class List < Parslet::Parser
      rule(:string) { ::Code::Parser::String.new }
      rule(:code) { ::Code::Parser::Code.new.present }

      rule(:opening_square_bracket) { str("[") }
      rule(:closing_square_bracket) { str("]") }
      rule(:comma) { str(",") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:list) do
        (
          opening_square_bracket.ignore >> whitespace?.ignore >>
            code.as(:code).repeat(0, 1) >>
            (whitespace? >> comma >> whitespace? >> code.as(:code)).repeat >>
            whitespace?.ignore >> comma.maybe.ignore >> whitespace?.ignore >>
            closing_square_bracket.ignore
        ).as(:list) | string
      end

      root(:list)
    end
  end
end
