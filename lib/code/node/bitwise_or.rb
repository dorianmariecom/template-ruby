class Code
  class Node
    class BitwiseOr
      PIPE = "|"
      CARET = "^"

      def initialize(bitwise_or)
        @first = ::Code::Node::Statement.new(bitwise_or.fetch(:first))
        @rest =
          bitwise_or
            .fetch(:rest)
            .map do |operator_and_statement|
              {
                operator: operator_and_statement.fetch(:operator),
                statement:
                  ::Code::Node::Statement.new(
                    operator_and_statement.fetch(:statement),
                  ),
              }
            end
      end

      def evaluate(context)
        object = @first.evaluate(context)

        @rest.each do |operator_and_statement|
          operator = operator_and_statement.fetch(:operator)
          other = operator_and_statement.fetch(:statement).evaluate(context)

          if operator == PIPE
            object = object.fetch(:|, other)
          elsif operator == CARET
            object = object.fetch(:^, other)
          else
            raise NotImplementedError.new(operator)
          end
        end

        object
      end
    end
  end
end
