class Code
  class Object
    class Dictionnary < ::Code::Object
      attr_reader :raw

      def initialize(raw = {})
        @raw = raw
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])

        if operator == "values"
          values(arguments)
        elsif key?(operator)
          fetch(operator)
        else
          super
        end
      end

      def fetch(key)
        raw.fetch(key)
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
