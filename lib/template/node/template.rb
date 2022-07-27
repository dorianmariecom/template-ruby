class Template
  class Node
    class Template
      def initialize(parts)
        @parts = parts.map { |part| ::Template::Node::Part.new(part) }
      end

      def evaluate(context)
        ::Code::Object::List.new(@parts.map { |part| part.evaluate(context) })
      end
    end
  end
end
