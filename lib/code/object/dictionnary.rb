class Code
  class Object
    class Dictionnary < ::Code::Object
      def initialize(raw = {})
        @raw = raw
      end

      def to_s
        "{#{raw.map { |key, value| key_value_to_s(key, value) }.join(", ")}}"
      end

      def inspect
        to_s
      end

      private

      attr_reader :raw

      def key_value_to_s(key, value)
        if key.is_a?(::Code::Object::String)
          "#{key.to_s}: #{value.inspect}"
        else
          "#{key.inspect} => #{value.inspect}"
        end
      end
    end
  end
end
