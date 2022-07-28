class Code
  class Object
    class Integer < ::Code::Object::Number
      attr_reader :raw

      def initialize(whole, exponent: nil)
        @raw = whole.to_i
        @raw = @raw * 10**exponent.raw if exponent && exponent.is_a?(::Code::Object::Number)
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
        raw.to_s
      end

      def inspect
        to_s
      end

      private

      def power(other)
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw ** other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw ** other.raw)
        else
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
