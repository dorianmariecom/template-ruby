class Template
  class Node
    class Template
      def initialize(parts)
        @parts = parts.map { |part| ::Template::Node::Part.new(part) }
      end

      def evaluate(**args)
        ::Code::Object::List.new(@parts.map { |part| part.evaluate(**args) })
      end
    end
  end
end
