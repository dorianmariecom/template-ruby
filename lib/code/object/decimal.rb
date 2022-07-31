class Code
  class Object
    class Decimal < ::Code::Object::Number
      ROUND_N = 35
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)
        @raw = @raw * 10**exponent.raw if exponent &&
          exponent.is_a?(::Code::Object::Number)
      end

      def evaluate(key, *args, **kargs)
        if %i[** * / %].include?(key)
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
          ::Code::Object::Nothing.new
        end
      end

      def integer_or_decimal_comparaison(operator, other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
