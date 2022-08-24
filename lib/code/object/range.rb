class Code
  class Object
    class Range < ::Code::Object
      attr_reader :raw

      def initialize(left, right, exclude_end: false)
        @raw = ::Range.new(left, right, exclude_end)
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)

        if operator == "any?"
          any?(arguments, context: context, io: io)
        elsif operator == "each"
          each(arguments, context: context, io: io)
        elsif operator == "first"
          first(arguments)
        elsif operator == "last"
          last(arguments)
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

      private

      def any?(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            argument.value.call(
              arguments: [::Code::Object::Argument.new(element)],
              context: context,
              io: io
            ).truthy?
          end
        )
      end

      def each(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        raw.each do |element|
          argument.value.call(
            arguments: [::Code::Object::Argument.new(element)],
            context: context,
            io: io
          )
        end
        self
      end

      def first(arguments)
        sig(arguments)
        raw.first
      end

      def last(arguments)
        sig(arguments)
        raw.last
      end
    end
  end
end
