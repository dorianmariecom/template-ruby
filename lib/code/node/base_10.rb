class Code
  class Node
    class Base10 < Node
      def initialize(parsed)
        @whole = parsed.delete(:whole)

        if parsed.key?(:exponent)
          @exponent = Node::Statement.new(parsed.delete(:exponent))
        end

        super(parsed)
      end

      def evaluate(**args)
        if @exponent
          exponent = @exponent.evaluate(**args)

          if exponent.is_a?(::Code::Object::Integer)
            ::Code::Object::Integer.new(@whole.to_i, exponent: exponent)
          else
            ::Code::Object::Decimal.new(@whole, exponent: exponent)
          end
        else
          ::Code::Object::Integer.new(@whole.to_i)
        end
      end
    end
  end
end
