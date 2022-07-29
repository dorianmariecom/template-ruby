class Code
  class Node
    class BitwiseAnd
      def initialize(bitwise_and)
        @statements =
          bitwise_and.map { |statement| ::Code::Node::Statement.new(statement) }
      end

      def evaluate(context)
        first = @statements.shift
        object = first.evaluate(context)

        @statements.each do |statement|
          other = statement.evaluate(context)
          object = object.fetch(:&, other)
        end

        object
      end
    end
  end
end
