class Template
  class Node
    class Template
      def initialize(parts)
        @parts = parts.map { |part| ::Template::Node::Part.new(part) }
      end

      def evaluate(**args)
        @parts.each { |part| args.fetch(:io).print(part.evaluate(**args)) }
      end
    end
  end
end
