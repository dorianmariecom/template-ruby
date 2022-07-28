class Code
  class Node
    class Negation
      EXCLAMATION_POINT = "!"
      PLUS = "+"

      def initialize(negation)
        @operator = negation.fetch(:operator)
        @code = ::Code::Node::Code.new(negation.fetch(:code))
      end

      def evaluate(context)
        object = @code.evaluate(context)

        if exclamation_point?
          case object
          when ::Code::Object::Nothing
            ::Code::Object::Boolean.new(true)
          when ::Code::Object::Boolean
            ::Code::Object::Boolean.new(!object.raw)
          else
            ::Code::Object::Boolean.new(false)
          end
        elsif plus?
          object
        else
          raise NotImplementedError.new(operator)
        end
      end

      private

      attr_reader :operator

      def exclamation_point?
        operator == EXCLAMATION_POINT
      end

      def plus?
        operator == PLUS
      end
    end
  end
end
