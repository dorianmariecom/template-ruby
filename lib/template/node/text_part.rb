class Template
  class Node
    class TextPart
      def initialize(text)
        @text = text
      end

      def evaluate(**args)
        ::Code::Object::String.new(@text.to_s)
      end
    end
  end
end
