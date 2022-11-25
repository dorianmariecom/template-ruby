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

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        if operator == "even?"
          sig(arguments)
          even?
        elsif operator == "odd?"
          sig(arguments)
          odd?
        elsif operator == "*"
          sig(arguments) { [[::Code::Object::Number, ::Code::Object::String]] }
          multiplication(value)
        elsif operator == "/"
          sig(arguments) { ::Code::Object::Number }
          division(value)
        elsif operator == "+"
          if value
            sig(arguments) { ::Code::Object }
            plus(value)
          else
            sig(arguments)
            self
          end
        elsif operator == "%"
          sig(arguments) { ::Code::Object::Number }
          modulo(value)
        elsif operator == "-"
          if value
            sig(arguments) { ::Code::Object::Number }
            minus(value)
          else
            sig(arguments)
            unary_minus
          end
        elsif operator == "**"
          sig(arguments) { ::Code::Object::Number }
          power(value)
        elsif operator == "<"
          sig(arguments) { ::Code::Object::Number }
          inferior(value)
        elsif operator == "<="
          sig(arguments) { ::Code::Object::Number }
          inferior_or_equal(value)
        elsif operator == ">"
          sig(arguments) { ::Code::Object::Number }
          superior(value)
        elsif operator == ">="
          sig(arguments) { ::Code::Object::Number }
          superior_or_equal(value)
        elsif operator == "<<"
          sig(arguments) { ::Code::Object::Number }
          left_shift(value)
        elsif operator == ">>"
          sig(arguments) { ::Code::Object::Number }
          right_shift(value)
        elsif operator == "&"
          sig(arguments) { ::Code::Object::Number }
          bitwise_and(value)
        elsif operator == "|"
          sig(arguments) { ::Code::Object::Number }
          bitwise_or(value)
        elsif operator == "^"
          sig(arguments) { ::Code::Object::Number }
          bitwise_xor(value)
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

      def even?
        ::Code::Object::Boolean.new(raw.even?)
      end

      def odd?
        ::Code::Object::Boolean.new(raw.odd?)
      end

      def multiplication(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw * other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw * other.raw)
        else
          ::Code::Object::String.new(other.raw * raw)
        end
      end

      def plus(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw + other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw + other.raw)
        else
          ::Code::Object::String.new(to_s + other.to_s)
        end
      end

      def division(other)
        ::Code::Object::Decimal.new(BigDecimal(raw) / other.raw)
      end

      def modulo(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw % other.raw)
        else
          ::Code::Object::Decimal.new(raw % other.raw)
        end
      end

      def minus(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw - other.raw)
        else
          ::Code::Object::Decimal.new(raw - other.raw)
        end
      end

      def unary_minus
        ::Code::Object::Integer.new(-raw)
      end

      def power(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw**other.raw)
        else
          ::Code::Object::Decimal.new(raw**other.raw)
        end
      end

      def inferior(other)
        ::Code::Object::Boolean.new(raw < other.raw)
      end

      def inferior_or_equal(other)
        ::Code::Object::Boolean.new(raw <= other.raw)
      end

      def superior(other)
        ::Code::Object::Boolean.new(raw > other.raw)
      end

      def superior_or_equal(other)
        ::Code::Object::Boolean.new(raw >= other.raw)
      end

      def left_shift(other)
        ::Code::Object::Integer.new(raw << other.raw.to_i)
      end

      def right_shift(other)
        ::Code::Object::Integer.new(raw >> other.raw.to_i)
      end

      def bitwise_and(other)
        ::Code::Object::Integer.new(raw & other.raw.to_i)
      end

      def bitwise_or(other)
        ::Code::Object::Integer.new(raw | other.raw.to_i)
      end

      def bitwise_xor(other)
        ::Code::Object::Integer.new(raw ^ other.raw.to_i)
      end
    end
  end
end
