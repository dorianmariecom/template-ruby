class Code
  class Object
    class Dictionnary < ::Code::Object
      attr_reader :raw

      def initialize(raw = {})
        @raw = raw
      end

      def call(arguments: [], context: ::Code::Object::Dictionnary.new, operator: nil)
        if operator == "values"
          values(arguments)
        else
          super
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

      private

      def values(arguments)
        sig(arguments)
        ::Code::Object::List.new(raw.values)
      end
    end
  end
end
