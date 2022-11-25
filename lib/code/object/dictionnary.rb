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
        globals = multi_fetch(args, *::Code::GLOBALS)
        value = arguments.first&.value

        if operator == "values"
          sig(arguments)
          values
        elsif operator == "keys"
          sig(arguments)
          keys
        elsif operator == "each"
          sig(arguments) { ::Code::Object::Function }
          each(value, **globals)
        elsif key?(operator)
          result = fetch(operator)

          if result.is_a?(::Code::Object::Function)
            result.call(**args.merge(operator: nil))
          else
            sig(arguments)
            result
          end
        else
          super
        end
      end

      def merge(other)
        ::Code::Object::Dictionnary.new(raw.merge(other.raw))
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

      def deep_dup
        ::Code::Object::Dictionnary.new(raw.deep_dup)
      end

      def to_s
        "{#{raw.map { |key, value| "#{key.inspect} => #{value.inspect}" }.join(", ")}}"
      end

      def inspect
        to_s
      end

      private

      def keys
        ::Code::Object::List.new(raw.keys)
      end

      def values
        ::Code::Object::List.new(raw.values)
      end

      def each(argument, **globals)
        raw.each do |key, value|
          argument.call(
            arguments: [
              ::Code::Object::Argument.new(key),
              ::Code::Object::Argument.new(value),
            ],
            **globals,
          )
        end

        self
      end
    end
  end
end
