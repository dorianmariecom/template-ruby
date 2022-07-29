class Code
  class Object
    class Integer < ::Code::Object::Number
      attr_reader :raw

      def initialize(whole, exponent: nil)
        @raw = whole.to_i
        @raw = @raw * 10**exponent.raw if exponent &&
          exponent.is_a?(::Code::Object::Number)
      end

      def fetch(key, *args, **kargs)
        if key == :**
          power(args.first)
        elsif key == :*
          multiplication(args.first)
        elsif key == :/
          division(args.first)
        elsif key == :%
          modulo(args.first)
        elsif key == :+
          addition(args.first)
        elsif key == :-
          substraction(args.first)
        elsif key == :<<
          left_shift(args.first)
        elsif key == :>>
          right_shift(args.first)
        elsif key == :&
          bitwise_and(args.first)
        elsif key == :|
          bitwise_or(args.first)
        elsif key == :^
          bitwise_xor(args.first)
        else
          ::Code::Object::Nothing.new
        end
      end

      def ==(other)
        raw == other.raw
      end
      alias_method :eql?, :==

      def hash
        [self.class, raw].hash
      end

      def to_s
        raw.to_s
      end

      def inspect
        to_s
      end

      private

      def power(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw**other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw**other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def multiplication(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw * other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw * other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def division(other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Decimal.new(BigDecimal(raw) / other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def modulo(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw % other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw % other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def addition(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw + other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw + other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def substraction(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw - other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw - other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def left_shift(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw << other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def right_shift(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw >> other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def bitwise_and(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw & other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def bitwise_or(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw | other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end

      def bitwise_xor(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw ^ other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
