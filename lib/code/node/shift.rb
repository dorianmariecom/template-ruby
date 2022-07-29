class Code
  class Node
    class Shift
      LEFT_SHIFT = "<<"
      RIGHT_SHIFT = ">>"

      def initialize(shift)
        @first = ::Code::Node::Statement.new(shift.fetch(:first))
        @rest =
          shift
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

          if operator == LEFT_SHIFT
            object = object.fetch(:<<, other)
          elsif operator == RIGHT_SHIFT
            object = object.fetch(:>>, other)
          else
            raise NotImplementedError.new(operator)
          end
        end

        object
      end
    end
  end
end
