class Code
  class Parser
    class List < ::Code::Parser
      def parse
        if match(OPENING_SQUARE_BRACKET)
          list = []

          list << parse_code
          list << parse_code while match(COMMA) && !end_of_input?

          match(CLOSING_SQUARE_BRACKET)

          { list: list.reject(&:empty?) }
        else
          parse_subclass(::Code::Parser::String)
        end
      end
    end
  end
end
