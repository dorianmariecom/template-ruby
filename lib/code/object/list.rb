class Code
  class Object
    class List < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
      end

      def inspect
        to_s
      end

      def map(&block)
        @raw = raw.map(&block)
        self
      end

      def join
        raw.join
      end

      def ==(other)
        raw == other.raw
      end
      alias_method :eql?, :==

      def hash
        [self.class, raw].hash
      end
    end
  end
end
