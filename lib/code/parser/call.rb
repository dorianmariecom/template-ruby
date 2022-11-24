class Code
  class Parser
    class Call < Language
      def name
        ::Code::Parser::Name
      end

      def whitespace
        ::Code::Parser::Whitespace
      end

      def whitespace?
        whitespace.maybe
      end

      def code
        ::Code::Parser::Code
      end

      def colon
        str(":")
      end

      def comma
        str(",")
      end

      def pipe
        str("|")
      end

      def equal
        str("=")
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def opening_parenthesis
        str("(")
      end

      def closing_parenthesis
        str(")")
      end

      def do_keyword
        str("do")
      end

      def end_keyword
        str("end")
      end

      def keyword_argument
        name.aka(:name) >> whitespace? >> colon >> code.aka(:value)
      end

      def regular_argument
        code.aka(:value)
      end

      def argument
        keyword_argument | regular_argument
      end

      def arguments
        opening_parenthesis << whitespace? << argument.repeat(0, 1) << (
          comma << argument
        ).repeat << whitespace? << closing_parenthesis.maybe
      end

      def keyword_parameter
        name.aka(:name) >> whitespace? >> colon.aka(:keyword) >>
          code.aka(:default)
      end

      def regular_parameter
        name.aka(:name) >> whitespace? >>
          (equal >> whitespace? >> code.aka(:default))
      end

      def parameter
        keyword_parameter | regular_parameter
      end

      def parameters
        pipe << whitespace? << parameter.repeat(0, 1) << (
          comma << parameter
        ).repeat << whitespace? << pipe.maybe
      end

      def block
        (
          do_keyword << whitespace? << parameters.aka(
            :parameters
          ).maybe << code.aka(:body) << end_keyword
        ) |
          (
            opening_curly_bracket << whitespace? << parameters.aka(
              :parameters
            ).maybe << code.aka(:body) << closing_curly_bracket
          )
      end

      def root
        (
          name.aka(:name) << whitespace? << arguments.aka(
            :arguments
          ).maybe << whitespace? << block.aka(:block).maybe
        ).aka(:call)
      end
    end
  end
end
