class Code
  class Parser
    class Call < Parslet::Parser
      rule(:dictionnary) { ::Code::Parser::Dictionnary.new }
      rule(:code) { ::Code::Parser::Code.new }
      rule(:name) { ::Code::Parser::Name.new }

      rule(:dot) { str(".") }
      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }
      rule(:comma) { str(",") }
      rule(:colon) { str(":") }
      rule(:ampersand) { str("&") }
      rule(:asterisk) { str("*") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:keyword_argument) do
        name >> whitespace? >> colon >>
          whitespace? >> code.as(:value)
      end

      rule(:regular_argument) do
        ampersand.as(:block).maybe >>
          (asterisk >> asterisk).as(:keyword_splat).maybe >>
          asterisk.as(:splat).maybe >> code
      end

      rule(:argument) do
        keyword_argument.as(:keyword) | regular_argument.as(:regular)
      end

      rule(:arguments) do
        argument.repeat(1, 1) >>
          (whitespace? >> comma >> whitespace? >> argument).repeat
      end

      rule(:single_call) do
        dictionnary.as(:left) >>
          (
            opening_parenthesis >> whitespace? >> arguments.as(:arguments).maybe >>
              whitespace? >> closing_parenthesis
          )
      end

      rule(:chained_call) do
        dictionnary.as(:left) >> dot >> call.as(:right) >>
          (
            opening_parenthesis >> whitespace? >> arguments.as(:arguments).maybe >>
              whitespace? >> closing_parenthesis
          ).maybe
      end

      rule(:call) do
        (
          single_call | chained_call
        ).as(:call) | dictionnary
      end

      root(:call)
    end
  end
end
