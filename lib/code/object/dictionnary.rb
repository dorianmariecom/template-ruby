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
        context = args.fetch(:context)
        io = args.fetch(:io)

        if operator == "values"
          values(arguments)
        elsif operator == "each"
          each(arguments, context: context, io: io)
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

      def values(arguments)
        sig(arguments)
        ::Code::Object::List.new(raw.values)
      end

      def each(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        raw.each do |key, value|
          argument.call(
            arguments: [
              ::Code::Object::Argument.new(key),
              ::Code::Object::Argument.new(value)
            ],
            context: context,
            io: io,
          )
        end
        self
      end
    end
  end
end
