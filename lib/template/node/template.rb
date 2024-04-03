# frozen_string_literal: true

class Template
  class Node
    class Template < Node
      def initialize(parts)
        @parts = parts.map { |part| ::Template::Node::Part.new(part) }
      end

      def evaluate(**args)
        output = args.fetch(:output)
        @parts.each { |part| output.print(part.evaluate(**args)) }
        ::Code::Object::Nothing.new
      end
    end
  end
end
