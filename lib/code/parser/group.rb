class Code
  class Parser
    class Group < Parslet::Parser
      rule(:name) { ::Code::Parser::Name.new }
      rule(:code) { ::Code::Parser::Code.new.present }

      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }

      rule(:group) do
        (opening_parenthesis >> code >> closing_parenthesis).as(:group) | name
      end

      root(:group)
    end
  end
end
