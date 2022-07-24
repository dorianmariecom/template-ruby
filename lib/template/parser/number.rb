class Template
  class Parser
    class Number < Parslet::Parser
      rule(:dot) { str(".") }
      rule(:plus) { str("+") }
      rule(:minus) { str("-") }

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
      rule(:o) { str("o") | str("O") }
      rule(:x) { str("x") | str("X") }

      # sign

      rule(:sign) { plus | minus }

      # base 2

      rule(:base_2_digit) { zero | one }

      rule(:base_2_number) { zero.ignore >> b.ignore >> base_2_digit.repeat(1) }

      # base 8

      rule(:base_8_digit) do
        zero | one | two | three | four | five | six | seven
      end

      rule(:base_8_number) { zero.ignore >> o.ignore >> base_8_digit.repeat(1) }

      # base 10

      rule(:base_10_digit) do
        zero | one | two | three | four | five | six | seven | eight | nine
      end

      rule(:base_10_whole) { base_10_digit.repeat(1) }

      rule(:base_10_exponent) { e.ignore >> base_10_number }

      rule(:base_10_integer) do
        sign.as(:sign).maybe >> base_10_whole.as(:whole) >>
          base_10_exponent.as(:exponent).maybe
      end

      rule(:base_10_decimal_decimal) { dot.ignore >> base_10_digit.repeat }

      rule(:base_10_decimal) do
        sign.as(:sign).maybe >> base_10_whole.as(:whole) >>
          base_10_decimal_decimal.as(:decimal) >>
          base_10_exponent.as(:exponent).maybe
      end

      rule(:base_10_number) do
        base_10_decimal.as(:decimal) | base_10_integer.as(:integer)
      end

      # base 16

      rule(:base_16_digit) do
        zero | one | two | three | four | five | six | seven | eight | nine |
          a | b | c | d | e | f
      end

      rule(:base_16_number) do
        zero.ignore >> x.ignore >> base_16_digit.repeat(1)
      end

      # number

      rule(:number) do
        (
          base_2_number.as(:base_2) | base_8_number.as(:base_8) |
            base_16_number.as(:base_16) | base_10_number.as(:base_10)
        ).as(:number)
      end

      root(:number)
    end
  end
end
