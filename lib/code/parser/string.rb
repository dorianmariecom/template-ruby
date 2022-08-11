class Code
  class Parser
    class String < Parslet::Parser
      rule(:number) { ::Code::Parser::Number.new }
      rule(:name) { ::Code::Parser::Name.new.name }

      rule(:single_quote) { str("'") }
      rule(:double_quote) { str('"') }
      rule(:backslash) { str("\\") }
      rule(:colon) { str(":") }

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
      rule(:a) { str("a") | str("A") }
      rule(:b) { str("b") | str("B") }
      rule(:b) { str("b") | str("B") }
      rule(:c) { str("c") | str("C") }
      rule(:d) { str("d") | str("D") }
      rule(:e) { str("e") | str("E") }
      rule(:f) { str("f") | str("F") }
      rule(:n) { str("n") | str("N") }
      rule(:r) { str("r") | str("R") }
      rule(:t) { str("t") | str("T") }
      rule(:u) { str("u") | str("U") }

      rule(:base_16_digit) do
        zero | one | two | three | four | five | six | seven | eight | nine |
          a | b | c | d | e | f
      end

      rule(:escaped_character) do
        (backslash >> u >> base_16_digit.repeat(4, 4)) |
          (backslash >> (b | f | n | r | t)) | (backslash.ignore >> any)
      end

      rule(:single_quoted_character) do
        escaped_character | (single_quote.absent? >> any)
      end

      rule(:double_quoted_character) do
        escaped_character | (double_quote.absent? >> any)
      end

      rule(:single_quoted_string) do
        single_quote.ignore >> single_quoted_character.repeat >>
          single_quote.ignore
      end

      rule(:double_quoted_string) do
        double_quote.ignore >> double_quoted_character.repeat >>
          double_quote.ignore
      end

      rule(:symbol) do
        colon.ignore >> name
      end

      rule(:string) do
        (single_quoted_string | double_quoted_string | symbol).as(:string) | number
      end

      root(:string)
    end
  end
end
