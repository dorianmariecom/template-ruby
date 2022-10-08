class Code
  class Parser
    class Dictionnary < Parslet::Parser
      rule(:list) { ::Code::Parser::List.new }
      rule(:code) { ::Code::Parser::Code.new.present }
      rule(:string) { ::Code::Parser::String.new }

      rule(:opening_curly_bracket) { str("{") }
      rule(:closing_curly_bracket) { str("}") }
      rule(:colon) { str(":") }
      rule(:equal) { str("=") }
      rule(:right_caret) { str(">") }
      rule(:comma) { str(",") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:key_value) do
        (string.as(:key) >> colon >> whitespace? >> code.as(:value)) |
          (
            code.as(:key) >> whitespace? >> equal >> right_caret >>
              whitespace? >> code.as(:value)
          )
      end

      rule(:dictionnary) do
        (
          opening_curly_bracket.ignore >> whitespace?.ignore >>
            key_value.repeat(0, 1) >>
            (whitespace? >> comma >> whitespace? >> key_value).repeat >>
            whitespace?.ignore >> comma.maybe.ignore >> whitespace?.ignore >>
            closing_curly_bracket.ignore
        ).as(:dictionnary) | list
      end

      root(:dictionnary)
    end
  end
end
