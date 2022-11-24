class Language
  class Parser
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
