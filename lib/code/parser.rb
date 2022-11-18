class Code
  class Parser
  end
end

Code::Parser =
  Language.create do
    rule(:whitespace) { Code::Parser::Whitespace }
    rule(:statement) { Code::Parser::Statement }

    root do
      (whitespace? << statement << whitespace?).repeat(1) | whitespace? { [] }
    end
  end
