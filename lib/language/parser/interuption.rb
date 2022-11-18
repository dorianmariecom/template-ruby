class Language
  class Parser
    class Interuption < StandardError
      def initialize(parser, atom = Atom.new)
        @parser = parser
        @atom = atom
      end

      def message
        "#{input}\n#{" " * cursor}^\n#{@atom.inspect}"
      end

      private

      def cursor
        @parser.cursor
      end

      def input
        @parser.input
      end
    end

    class EndOfInput < Interuption
    end

    class NotEndOfInput < Interuption
    end

    class Absent
      class Present < Interuption
      end
    end

    class Str
      class NotFound < Interuption
        def initialize(parser, string)
          @parser = parser
          @string = string
        end

        def message
          "#{@string} not found\n#{super}"
        end
      end
    end
  end
end
