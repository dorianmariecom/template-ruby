class Code
  class Parser
    class Defined < Parslet::Parser
      rule(:equal) { ::Code::Parser::Equal.new }
      rule(:name) { ::Code::Parser::Name.new }

      rule(:defined_keyword) { str("defined?") }
      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }

      rule(:defined) do
        (
          defined_keyword >> opening_parenthesis >> name >> closing_parenthesis
        ).as(:defined) | equal
      end

      root(:defined)
    end
  end
end
