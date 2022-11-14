class Code
  class Node
    class Decimal < Node
      def initialize(parsed)
        if parsed.is_a?(::String)
          @decimal = parsed
        else
          @value = parsed.delete(:value)
          @exponent = ::Code::Node::Statement.new(parsed.delete(:exponent))
        end
      end

      def evaluate(**args)
        if @decimal
          ::Code::Object::Decimal.new(@decimal)
        else
          exponent = @exponent.evaluate(**args)

          ::Code::Object::Decimal.new(@value, exponent: exponent)
        end
      end
    end
  end
end
