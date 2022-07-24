class Code
  class Parser
    class Name < Parslet::Parser
      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:comma) { str(",") }
      rule(:colon) { str(":") }
      rule(:dot) { str(".") }
      rule(:single_quote) { str("'") }
      rule(:double_quote) { str('"') }
      rule(:opening_curly_bracket) { str("{") }
      rule(:closing_curly_bracket) { str("}") }
      rule(:opening_square_bracket) { str("[") }
      rule(:closing_square_bracket) { str("]") }
      rule(:equal) { str("=") }
      rule(:left_caret) { str("<") }
      rule(:right_caret) { str(">") }

      rule(:zero) { str("0") }
      rule(:one) { str("1") }
      rule(:two) { str("2") }
      rule(:three) { str("3") }
      rule(:four) { str("4") }
      rule(:five) { str("5") }
      rule(:six) { str("6") }
      rule(:seven) { str("7") }
      rule(:eight) { str("8") }
      rule(:nine) { str("9") }

      rule(:digit) do
        zero | one | two | three | four | five | six | seven | eight | nine
      end

      rule(:name_character) do
        space.absent? >> newline.absent? >> comma.absent? >> colon.absent? >>
          dot.absent? >> single_quote.absent? >> double_quote.absent? >>
          opening_curly_bracket.absent? >> closing_curly_bracket.absent? >>
          opening_square_bracket.absent? >> closing_square_bracket.absent? >>
          equal.absent? >> left_caret.absent? >> right_caret.absent? >> any
      end

      rule(:name) do
        (digit.absent? >> name_character >> name_character.repeat).as(:name)
      end

      root(:name)
    end
  end
end
