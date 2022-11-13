class Code
  class Node
    class Code < Node
      def initialize(parsed)
        @statements =
          parsed.map { |statement| ::Code::Node::Statement.new(statement) }
      end

      def evaluate(**args)
        last = ::Code::Object::Nothing.new
        args[:object] = ::Code::Object::Global.new

        @statements.each { |statement| last = statement.evaluate(**args) }

        last
      end
    end
  end
end
