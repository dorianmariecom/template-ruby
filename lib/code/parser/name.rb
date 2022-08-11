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
      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }
      rule(:equal) { str("=") }
      rule(:left_caret) { str("<") }
      rule(:right_caret) { str(">") }
      rule(:tilde) { str("~") }
      rule(:pipe) { str("|") }
      rule(:ampersand) { str("&") }
      rule(:asterisk) { str("*") }
      rule(:slash) { str("/") }
      rule(:antislash) { str("\\") }
      rule(:percent) { str("%") }
      rule(:plus) { str("+") }
      rule(:minus) { str("-") }
      rule(:equal) { str("=") }

      rule(:exclamation_point) { str("!") }
      rule(:question_mark) { str("?") }

      rule(:rescue_keyword) { str("rescue") }
      rule(:defined_keyword) { str("defined?") }
      rule(:not_keyword) { str("not") }
      rule(:or_keyword) { str("or") }
      rule(:and_keyword) { str("and") }
      rule(:if_keyword) { str("if") }
      rule(:else_keyword) { str("else") }
      rule(:unless_keyword) { str("unless") }
      rule(:until_keyword) { str("until") }
      rule(:while_keyword) { str("while") }
      rule(:end_keyword) { str("end") }

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
        opening_parenthesis.absent? >> closing_parenthesis.absent? >>
          exclamation_point.absent? >> question_mark.absent? >> tilde.absent? >>
          pipe.absent? >> ampersand.absent? >> asterisk.absent? >>
          slash.absent? >> antislash.absent? >> percent.absent? >>
          plus.absent? >> minus.absent? >> equal.absent? >> space.absent? >>
          newline.absent? >> comma.absent? >> colon.absent? >> dot.absent? >>
          single_quote.absent? >> double_quote.absent? >>
          opening_curly_bracket.absent? >> closing_curly_bracket.absent? >>
          opening_square_bracket.absent? >> closing_square_bracket.absent? >>
          equal.absent? >> left_caret.absent? >> right_caret.absent? >> any
      end

      rule(:name) do
        rescue_keyword.absent? >> defined_keyword.absent? >>
          not_keyword.absent? >> or_keyword.absent? >> and_keyword.absent? >>
          if_keyword.absent? >> else_keyword.absent? >>
          unless_keyword.absent? >> until_keyword.absent? >>
          while_keyword.absent? >> digit.absent? >> end_keyword.absent? >>
          name_character >> name_character.repeat >> question_mark.maybe >>
          exclamation_point.maybe
      end

      rule(:name_rule) do
        name.as(:name)
      end

      root(:name_rule)
    end
  end
end
