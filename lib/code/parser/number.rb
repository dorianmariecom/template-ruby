class Code
  class Parser
    class Number < ::Code::Parser
      def parse
        if match(DIGITS)
          if match(X)
            parse_base(16)
          elsif match(O)
            parse_base(8)
          elsif match(B)
            parse_base(2)
          else
            parse_number
          end
        else
          parse_subclass(::Code::Parser::Boolean)
        end
      end

      def parse_base(base)
        buffer!
        consume while (next?(DIGITS) || next?(UNDERSCORE)) && !end_of_input?

        { integer: buffer.gsub(UNDERSCORE, EMPTY_STRING).to_i(base) }
      end

      def parse_number
        consume while (next?(DIGITS) || next?(UNDERSCORE)) && !end_of_input?

        if next?(DOT) && next_next?(DIGITS)
          consume
          consume while (next?(DIGITS) || next?(UNDERSCORE)) && !end_of_input?

          decimal = buffer!.gsub(UNDERSCORE, EMPTY_STRING)

          if match(E)
            buffer!
            exponent = parse_number
            { decimal: { value: decimal, exponent: exponent } }
          else
            { decimal: decimal }
          end
        else
          integer = buffer!.gsub(UNDERSCORE, EMPTY_STRING).to_i

          if match(E)
            buffer!
            exponent = parse_number
            { integer: { value: integer, exponent: exponent } }
          else
            { integer: integer }
          end
        end
      end
    end
  end
end
