class Code
  class Node
    class Code < Node
      def initialize(statements)
        statements = [] if statements.to_s.blank?

        @statements =
          statements.map { |statement| ::Code::Node::Statement.new(statement) }
      end

      def evaluate(**args)
        last = ::Code::Object::Nothing.new

        @statements.each { |statement| last = statement.evaluate(**args) }

        last
      end
    end
  end
end
