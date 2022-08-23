class Code
  class Node
    class Negation < Node
      EXCLAMATION_POINT = "!"
      PLUS = "+"

      def initialize(negation)
        @operator = negation.fetch(:operator)
        @statement = ::Code::Node::Statement.new(negation.fetch(:statement))
      end

      def evaluate(context)
        object = @statement.evaluate(context)

        if operator == EXCLAMATION_POINT
          if object.truthy?
            ::Code::Object::Boolean.new(false)
          else
            ::Code::Object::Boolean.new(true)
          end
        elsif operator == PLUS
          object
        else
          raise NotImplementedError.new(operator)
        end
      end

      private

      attr_reader :operator
    end
  end
end
