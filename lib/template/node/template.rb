class Template
  class Node
    class Template < Node
      def initialize(parts)
        @parts = parts.map { |part| ::Template::Node::Part.new(part) }
      end

      def evaluate(**args)
        io = args.fetch(:io)

        @parts.each { |part| io.print(part.evaluate(**args)) }
      end
    end
  end
end
