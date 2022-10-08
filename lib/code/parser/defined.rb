class Code
  class Parser
    class Defined < Parslet::Parser
      rule(:range) { ::Code::Parser::Range.new }
      rule(:name) { ::Code::Parser::Name.new }

      rule(:defined_keyword) { str("defined?") }
      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }

      rule(:defined) do
        (
          defined_keyword >> opening_parenthesis >> name >> closing_parenthesis
        ).as(:defined) | range
      end

      root(:defined)
    end
  end
end
