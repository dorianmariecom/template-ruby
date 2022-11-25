class Code
  class Node
    class ChainedCall < Node
      def initialize(parsed)
        @first = Node::Statement.new(parsed.delete(:first))
        @others =
          parsed
            .delete(:others)
            .map { |operator| Node::Statement.new(operator) }

        super(parsed)
      end

      def evaluate(**args)
        first = @first.evaluate(**args)

        @others.reduce(first) do |acc, element|
          element.evaluate(**args.merge(object: acc))
        end
      end
    end
  end
end
