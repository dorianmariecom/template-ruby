Code::Parser::Boolean = Language.create do
  rule(:true_keyword) { str("true") }
  rule(:false_keyword) { str("false") }

  root { (true_keyword | false_keyword).aka(:boolean) | Code::Parser::Nothing }
end
