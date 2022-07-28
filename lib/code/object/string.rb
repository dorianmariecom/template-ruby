require "bigdecimal"

class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def fetch(key, *args, **kargs)
        ::Code::Object::Nothing.new
      end

      def ==(other)
        raw == other.raw
      end
      alias_method :eql?, :==

      def hash
        [self.class, raw].hash
      end

      def to_s
        raw
      end

      def inspect
        raw.inspect
      end
    end
  end
end
