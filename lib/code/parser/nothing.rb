Code::Parser::Nothing =
  Language.create do
    rule(:nothing_keyword) { str("nothing") }
    rule(:null_keyword) { str("null") }
    rule(:nil_keyword) { str("nil") }

    root { (nothing_keyword | null_keyword | nil_keyword).aka(:nothing) }
  end
