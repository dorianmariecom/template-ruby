class Code
  class Node
    class ChainedCall < Node
      def initialize(parsed)
        calls = parsed.delete(:calls)

        @first = ::Code::Node::Statement.new(calls.first.fetch(:left))
        @second = ::Code::Node::Statement.new(calls.first.fetch(:right))
        @rest =
          calls[1..].map do |statement|
            ::Code::Node::Statement.new(statement.delete(:right))
          end

        super(parsed)
      end

      def evaluate(**args)
        left = @first.evaluate(**args)
        left = @second.evaluate(**args.merge(object: left))

        @rest.reduce(left) do |acc, element|
          element.evaluate(**args.merge(object: acc))
        end
      end
    end
  end
end
