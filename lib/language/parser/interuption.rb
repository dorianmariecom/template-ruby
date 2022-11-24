class Language
  class Parser
    class Interuption < StandardError
      def initialize(parser, atom = Atom.new)
        @parser = parser
        @atom = atom
      end

      def message
        "\n#{input}\n#{" " * cursor}^\n#{@atom.inspect}"
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
