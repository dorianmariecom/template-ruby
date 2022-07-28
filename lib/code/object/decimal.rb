require "bigdecimal"

class Code
  class Object
    class Decimal < ::Code::Object
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)
        @raw = @raw * 10**exponent.raw if exponent
      end

      def to_s
        raw.to_s("F")
      end

      def inspect
        to_s
      end

      def ==(other)
        raw == other.raw
      end
      alias_method :eql?, :==

      def hash
        [self.class, raw].hash
      end

      def fetch(key, default = ::Code::Object::Nothing.new, *args, **kargs)
        default
      end
    end
  end
end
