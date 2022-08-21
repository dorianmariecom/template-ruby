class Code
  class Object
    class Range < ::Code::Object
      attr_reader :raw

      def initialize(left, right, exclude_end: false)
        @raw = ::Range.new(left, right, exclude_end)
      end

      def evaluate(key, *args, **kargs)
        if key == "first"
          raw.first
        elsif key == "last"
          raw.last
        elsif key == "any?"
          raise args.inspect
        else
          super
        end
      end

      def to_s
        raw.to_s
      end

      def inspect
        to_s
      end
    end
  end
end
