class Code
  class Object
    class Decimal < ::Code::Object::Number
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)

        if exponent
          if exponent.is_a?(::Code::Object::Number)
            @raw = @raw * 10**exponent.raw
          else
            raise ::Code::Error::TypeError.new("exponent is not a number")
          end
        end
      end

      def evaluate(key, *args, **kargs)
        if %i[** * / % + -].include?(key)
          number_operation(key, args.first)
        elsif %i[> >= < <=].include?(key)
          number_comparaison(key, args.first)
        else
          super
        end
      end

      def to_s
        raw.to_s("F")
      end

      def inspect
        to_s
      end

      private

      def number_operation(operator, other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Decimal.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new(
                  "#{operator} only supports numbers",
                )
        end
      end

      def number_comparaison(operator, other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new(
                  "#{operator} only supports numbers",
                )
        end
      end
    end
  end
end
