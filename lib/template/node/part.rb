class Template
  class Node
    class Part < Node
      def initialize(part)
        if part.key?(:text)
          @part = ::Template::Node::TextPart.new(part[:text])
        elsif part.key?(:code)
          @part = ::Template::Node::CodePart.new(part[:code])
        else
          raise NotImplementedError.new(part.inspect)
        end
      end

      def evaluate(**args)
        @part.evaluate(**args)
      end
    end
  end
end
