class Code
  class Node
    class UnaryMinus
      def initialize(unary_minus)
        @code = ::Code::Node::Code.new(unary_minus)
      end

      def evaluate(context)
        object = @code.evaluate(context)

        case object
        when ::Code::Object::Integer
          ::Code::Object::Integer.new(-object.raw)
        when ::Code::Object::Decimal
          ::Code::Object::Decimal.new(-object.raw)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
