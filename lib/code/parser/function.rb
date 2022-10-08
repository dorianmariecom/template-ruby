class Code
  class Parser
    class Function < Parslet::Parser
      rule(:call) { ::Code::Parser::Call.new }
      rule(:code) { ::Code::Parser::Code.new.present }
      rule(:name) { ::Code::Parser::Name.new }

      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }
      rule(:equal) { str("=") }
      rule(:right_caret) { str(">") }
      rule(:opening_curly_bracket) { str("{") }
      rule(:closing_curly_bracket) { str("}") }
      rule(:comma) { str(",") }
      rule(:colon) { str(":") }
      rule(:asterisk) { str("*") }
      rule(:ampersand) { str("&") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:keyword_argument) do
        name >> whitespace? >> colon >> (whitespace? >> code.as(:default)).maybe
      end

      rule(:regular_argument) do
        ampersand.as(:block).maybe >>
          (asterisk >> asterisk).as(:keyword_splat).maybe >>
          asterisk.as(:splat).maybe >> name >>
          (whitespace? >> equal >> whitespace? >> code.as(:default)).maybe
      end

      rule(:argument) do
        keyword_argument.as(:keyword) | regular_argument.as(:regular)
      end

      rule(:arguments) do
        argument.repeat(1, 1) >>
          (whitespace? >> comma >> whitespace? >> argument).repeat
      end

      rule(:function) do
        (
          opening_parenthesis >> whitespace? >>
            arguments.as(:arguments).maybe >> whitespace? >>
            closing_parenthesis >> whitespace? >> equal >> right_caret >>
            whitespace? >> opening_curly_bracket >> code.as(:body).maybe >>
            closing_curly_bracket
        ).as(:function) | call
      end

      root(:function)
    end
  end
end
