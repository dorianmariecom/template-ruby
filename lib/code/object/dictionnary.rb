class Code
  class Object
    class Dictionnary < ::Code::Object
      attr_reader :raw

      def initialize(raw = {})
        @raw = raw
      end

      def evaluate(key, *args, **kargs)
        raw.fetch(key) do
          if key == "values"
            ::Code::Object::List.new(raw.values)
          else
            super
          end
        end
      end

      def [](key)
        raw[key]
      end

      def []=(key, value)
        raw[key] = value
      end

      def key?(key)
        raw.key?(key)
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
