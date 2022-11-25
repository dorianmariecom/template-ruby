class Code
  class Parser
    class Number < Language
      def number
        ::Code::Parser::Number
      end

      def zero
        str("0")
      end

      def one
        str("1")
      end

      def two
        str("2")
      end

      def three
        str("3")
      end

      def four
        str("4")
      end

      def five
        str("5")
      end

      def six
        str("6")
      end

      def seven
        str("7")
      end

      def eight
        str("8")
      end

      def nine
        str("9")
      end

      def dot
        str(".")
      end

      def a
        str("a") | str("A")
      end

      def b
        str("b") | str("B")
      end

      def c
        str("c") | str("C")
      end

      def d
        str("d") | str("D")
      end

      def e
        str("e") | str("E")
      end

      def f
        str("f") | str("F")
      end

      def o
        str("o") | str("O")
      end

      def x
        str("x") | str("X")
      end

      def underscore
        str("_")
      end

      def base_16_digit
        zero | one | two | three | four | five | six | seven | eight | nine |
          a | b | c | d | e | f
      end

      def base_10_digit
        zero | one | two | three | four | five | six | seven | eight | nine
      end

      def base_8_digit
        zero | one | two | three | four | five | six | seven
      end

      def base_2_digit
        zero | one
      end

      def base_16_whole
        base_16_digit << (underscore.ignore | base_16_digit).repeat
      end

      def base_10_whole
        base_10_digit << (underscore.ignore | base_10_digit).repeat
      end

      def base_8_whole
        base_8_digit << (underscore.ignore | base_8_digit).repeat
      end

      def base_2_whole
        base_2_digit << (underscore.ignore | base_2_digit).repeat
      end

      def exponent
        (e << number).aka(:exponent)
      end

      def decimal
        (base_10_whole << dot << base_10_whole).aka(:decimal) << exponent.maybe
      end

      def base_16_number
        zero.ignore << x.ignore << base_16_whole
      end

      def base_10_number
        base_10_whole.aka(:whole) << exponent.maybe
      end

      def base_8_number
        zero.ignore << o.ignore << base_8_whole
      end

      def base_2_number
        zero.ignore << b.ignore << base_2_whole
      end

      def root
        (
          decimal.aka(:decimal) | base_16_number.aka(:base_16) |
            base_8_number.aka(:base_8) | base_2_number.aka(:base_2) |
            base_10_number.aka(:base_10)
        ).aka(:number) | ::Code::Parser::Boolean
      end
    end
  end
end
