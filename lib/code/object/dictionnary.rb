class Code
  class Object
    class Dictionnary < ::Code::Object
      attr_reader :raw

      def initialize(raw = {})
        @raw = raw
      end

      def evaluate(key, *args, **kargs)
        raw.fetch(key) { super }
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
