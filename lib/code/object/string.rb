require "bigdecimal"

class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def to_s
        raw
      end

      def inspect
        raw.inspect
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
