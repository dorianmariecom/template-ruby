class Code
  class Object
    class Integer < ::Code::Object::Number
      attr_reader :raw

      def initialize(whole, exponent: nil)
        @raw = whole.to_i

        if exponent
          if exponent.is_a?(::Code::Object::Number)
            @raw = @raw * 10**exponent.raw
          else
            raise ::Code::Error::TypeError.new("exponent is not a number")
          end
        end
      end

      def evaluate(key, *args, **kargs)
        if key == :/
          division(args.first)
        elsif %i[** * % + -].include?(key)
          integer_or_decimal_operation(key, args.first)
        elsif %i[<< >> & | ^].include?(key)
          integer_operation(key, args.first)
        elsif %i[> >= < <=].include?(key)
          integer_or_decimal_comparaison(key, args.first)
        else
          super
        end
      end

      def succ
        ::Code::Object::Integer.new(raw + 1)
      end

      def to_s
        raw.to_s
      end

      def inspect
        to_s
      end

      private

      def division(other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Decimal.new(BigDecimal(raw) / other.raw)
        else
          raise ::Code::Error::TypeError.new("/ only supports numbers")
        end
      end

      def integer_or_decimal_operation(operator, other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw.public_send(operator, other.raw))
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new("#{operator} only supports numbers")
        end
      end

      def integer_operation(operator, other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new("#{operator} only supports integers")
        end
      end

      def integer_or_decimal_comparaison(operator, other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new("#{operator} only supports numbers")
        end
      end
    end
  end
end
