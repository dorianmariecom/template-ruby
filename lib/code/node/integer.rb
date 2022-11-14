class Code
  class Node
    class Integer < Node
      def initialize(parsed)
        if parsed.is_a?(::Integer)
          @integer = parsed
        else
          @value = parsed.delete(:value)
          @exponent = ::Code::Node::Statement.new(parsed.delete(:exponent))
        end
      end

      def evaluate(**args)
        if @integer
          ::Code::Object::Integer.new(@integer)
        else
          exponent = @exponent.evaluate(**args)

          if exponent.is_a?(::Code::Object::Integer)
            ::Code::Object::Integer.new(@value, exponent: exponent)
          elsif exponent.is_a?(::Code::Object::Decimal)
            ::Code::Object::Decimal.new(@value, exponent: exponent)
          else
            raise NotImplementedError.new(exponent.inspect)
          end
        end
      end
    end
  end
end
