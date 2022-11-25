class Code
  class Node
    class Operation < Node
      class Operator < Node
        attr_reader :operator, :statement

        def initialize(parsed)
          @operator = parsed.delete(:operator)
          @statement = Node::Statement.new(parsed.delete(:statement))
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

        @others.reduce(first) do |left, right|
          statement = right.statement.evaluate(**args)

          left.call(
            operator: right.operator,
            arguments: [::Code::Object::Argument.new(statement)],
            **args
          )
        end
      end
    end
  end
end
