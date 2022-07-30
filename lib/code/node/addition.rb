class Code
  class Node
    class Addition < Operator
      PLUS = "+"
      MINUS = "-"

      def initialize(addition)
        @first = ::Code::Node::Statement.new(addition.fetch(:first))
        @rest =
          addition
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

          if operator == PLUS
            object = object.fetch(:+, other)
          elsif operator == MINUS
            object = object.fetch(:-, other)
          else
            raise NotImplementedError.new(operator)
          end
        end

        object
      end
    end
  end
end
