class Code
  class Node
    class Operation < Node
      class Operation
        attr_reader :operator, :statement

        def initialize(operation)
          @operator = operation.fetch(:operator).to_s
          @statement = ::Code::Node::Statement.new(operation.fetch(:statement))
        end
      end

      def initialize(operation)
        @first = ::Code::Node::Statement.new(operation.fetch(:first))
        @rest = operation.fetch(:rest)
        @rest.map! do |operation|
          ::Code::Node::Operation::Operation.new(operation)
        end
      end

      def evaluate(context)
        object = @first.evaluate(context)

        @rest.each do |operation|
          other = operation.statement.evaluate(context)
          object = simple_call(object, operation.operator, other)
        end

        object
      end
    end
  end
end
