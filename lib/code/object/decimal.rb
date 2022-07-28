require "bigdecimal"

class Code
  class Object
    class Decimal < ::Code::Object::Number
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)
        @raw = @raw * 10 ** exponent.raw if exponent && exponent.is_a?(::Code::Object::Number)
      end

      def fetch(key, *args, **kargs)
        if key == :power
          power(args.first)
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
        raw.to_s("F")
      end

      def inspect
        to_s
      end

      private

      def power(other)
        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Decimal.new(raw ** other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
