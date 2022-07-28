class Code
  class Object
    class Dictionnary < ::Code::Object
      attr_reader :raw

      def initialize(raw = {})
        @raw = raw
      end

      def fetch(key, *args, **kargs)
        raw.fetch(key) { ::Code::Object::Nothing.new }
      end

      def ==(other)
        raw == other.raw
      end
      alias_method :eql?, :==

      def hash
        [self.class, raw].hash
      end

      def to_s
        "{#{raw.map { |key, value| "#{key.inspect} => #{value.inspect}" }.join(", ")}}"
      end

      def inspect
        to_s
      end
    end
  end
end
