class Code
  class Node
    class OrKeyword < Node
      OR_KEYWORD = "or"
      AND_KEYWORD = "and"

      def initialize(or_keyword)
        @first = ::Code::Node::Statement.new(or_keyword.fetch(:first))
        @rest = or_keyword.fetch(:rest)
        @rest.map! do |operation|
          ::Code::Node::Operation::Operation.new(operation)
        end
      end

      def evaluate(context)
        object = @first.evaluate(context)

        @rest.each do |operation|
          if operation.operator == OR_KEYWORD
            return object if object.truthy?
          elsif operation.operator == AND_KEYWORD
            return object unless object.truthy?
          else
            raise NotImplementedError.new(operation.operator.inspect)
          end

          object = operation.statement.evaluate(context)
        end

        object
      end
    end
  end
end
