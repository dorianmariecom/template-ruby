# frozen_string_literal: true

class Template
  class Node
    class TextPart < Node
      def initialize(text)
        @text = text
      end

      def evaluate(**_args)
        ::Code::Object::String.new(@text.to_s)
      end
    end
  end
end
