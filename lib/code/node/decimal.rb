class Code
  class Node
    class Decimal < Node
      def initialize(parsed)
        @decimal = parsed.delete(:decimal)

        if parsed.key?(:exponent)
          @exponent = Node::Statement.new(parsed.delete(:exponent))
        end

        super(parsed)
      end

      def evaluate(**args)
        if @exponent
          ::Code::Object::Decimal.new(
            @decimal,
            exponent: @exponent.evaluate(**args)
          )
        else
          ::Code::Object::Decimal.new(@decimal)
        end
      end
    end
  end
end
