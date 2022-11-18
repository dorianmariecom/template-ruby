Code::Parser::Whitespace =
  Language.create do
    rule(:space) { str(" ") }
    rule(:newline) { str("\n") }
    rule(:hashtag) { str("#") }
    rule(:slash) { str("/") }
    rule(:asterisk) { str("*") }

    rule(:hash_comment) do
      hashtag << (newline.absent << any).repeat << newline.maybe
    end

    rule(:double_slash_comment) do
      slash << slash << (newline.absent << any).repeat << newline.maybe
    end

    rule(:multi_line_comment) do
      slash << asterisk << (
        (asterisk << slash).absent << any
      ).repeat << asterisk.maybe << slash.maybe
    end

    root do
      (
        space | newline | hash_comment | double_slash_comment |
          multi_line_comment
      ).repeat(1)
    end
  end
