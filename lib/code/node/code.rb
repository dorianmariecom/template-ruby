class Code
  class Node
    class Code
      def initialize(parsed)
        @statements = parsed.map { |statement| Node::Statement.new(statement) }
      end

      def evaluate(**args)
        last = ::Code::Object::Nothing.new

        @statements.each { |statement| last = statement.evaluate(**args) }

        last
      end
    end
  end
end
