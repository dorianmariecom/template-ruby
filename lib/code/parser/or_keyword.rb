class Code
  class Parser
    class OrKeyword < Parslet::Parser
      rule(:not_keyword) { ::Code::Parser::NotKeyword.new }

      rule(:or_keyword) { str("or") }
      rule(:and_keyword) { str("and") }

      rule(:operator) { or_keyword | and_keyword }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:or_rule) do
        (
          not_keyword.as(:first) >>
            (
              whitespace? >> operator.as(:operator) >> whitespace? >>
                not_keyword.as(:statement)
            ).repeat(1).as(:rest)
        ).as(:or_keyword) | not_keyword
      end

      root(:or_rule)
    end
  end
end
