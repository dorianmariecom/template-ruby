class Code
  class Object
    class Nothing < ::Code::Object
      attr_reader :raw

      def initialize
        @raw = nil
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
        ""
      end

      def inspect
        "nothing"
      end
    end
  end
end
