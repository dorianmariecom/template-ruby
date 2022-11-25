class Code
  class Node
    class Operation < Node
      class Operator < Node
        def initialize(parsed)
          @operator = parsed.delete(:operator)
          @statement = Node::Statement.new(parsed.delete(:statement))
        end

        def evaluate(**args)
          raise NotImplementedError
        end
      end

      def initialize(parsed)
        @first = Node::Statement.new(parsed.delete(:first))
        @others =
          parsed
            .delete(:others)
            .map { |operator| Node::Operation::Operator.new(operator) }

        super(parsed)
      end

      def evaluate(**args)
        first = @first.evaluate(**args)

        raise NotImplementedError
      end
    end
  end
end
