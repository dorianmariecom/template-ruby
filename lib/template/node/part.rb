class Template
  class Node
    class Part
      def initialize(part)
        if part.key?(:text)
          @part = ::Template::Node::TextPart.new(part[:text])
        elsif part.key?(:code)
          @part = ::Template::Node::CodePart.new(part[:code])
        else
          raise NotImplementedError.new(part.inspect)
        end
      end

      def evaluate(context)
        @part.evaluate(context)
      end
    end
  end
end
