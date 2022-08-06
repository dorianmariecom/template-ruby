class Code
  class Object
    class List < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def evaluate(key, *args, **kargs)
        if key == "first"
          raw.first
        elsif key == "last"
          raw.last
        else
          super
        end
      end

      def map(&block)
        @raw = raw.map(&block)
        self
      end

      def join
        raw.join
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
      end

      def inspect
        to_s
      end
    end
  end
end
