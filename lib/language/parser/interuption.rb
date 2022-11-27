class Language
  class Parser
    class Interuption < StandardError
      def initialize(parser, atom = Atom.new)
        @parser = parser
        @atom = atom
      end

      def message
        "\n#{line}#{" " * column_index}^\n"
      end

      def line
        l = input.lines[line_index]
        l += "\n" if l[-1] != "\n"
        l
      end

      def line_index
        input[...cursor].count("\n")
      end

      def column_index
        cursor - input.lines[...line_index].map(&:size).sum
      end

      private

      def cursor
        @parser.cursor
      end

      def input
        @parser.input
      end
    end
  end
end
