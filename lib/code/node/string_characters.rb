class Code
  class Node
    class StringCharacters < Node
      def initialize(characters)
        @characters = characters
      end

      def evaluate(**args)
        ::Code::Object::String.new(@characters.to_s)
      end
    end
  end
end
