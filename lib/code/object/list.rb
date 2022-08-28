class Code
  class Object
    class List < ::Code::Object
      attr_reader :raw

      def initialize(raw = [])
        @raw = raw
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)

        if operator == "any?"
          any?(arguments, context: context, io: io)
        elsif operator == "none?"
          none?(arguments, context: context, io: io)
        elsif operator == "detect"
          detect(arguments, context: context, io: io)
        elsif operator == "reduce"
          reduce(arguments, context: context, io: io)
        elsif operator == "each"
          each(arguments, context: context, io: io)
        elsif operator == "select"
          select(arguments, context: context, io: io)
        elsif operator == "map"
          map(arguments, context: context, io: io)
        elsif operator == "max"
          max(arguments)
        elsif operator == "flatten"
          flatten(arguments)
        elsif operator == "reverse"
          reverse(arguments)
        elsif operator == "first"
          first(arguments)
        elsif operator == "last"
          last(arguments)
        elsif operator == "max_by"
          max_by(arguments, context: context, io: io)
        elsif operator == "<<"
          append(arguments)
        else
          super
        end
      end

      def <<(element)
        raw << element
      end

      def flatten(arguments)
        sig(arguments)
        ::Code::Object::List.new(
          raw.reduce([]) do |acc, element|
            if element.is_a?(::Code::Object::List)
              acc + element.flatten(arguments).raw
            else
              acc + [element]
            end
          end
        )
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
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
            argument
              .value
              .call(
                arguments: [::Code::Object::Argument.new(element)],
                context: context,
                io: io,
              )
              .truthy?
          end,
        )
      end

      def none?(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        ::Code::Object::Boolean.new(
          raw.none? do |element|
            argument
              .value
              .call(
                arguments: [::Code::Object::Argument.new(element)],
                context: context,
                io: io,
              )
              .truthy?
          end,
        )
      end

      def max_by(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        raw.max_by do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            context: context,
            io: io,
          )
        end || ::Code::Object::Nothing.new
      end

      def detect(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        raw.detect do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            context: context,
            io: io,
          ).truthy?
        end || ::Code::Object::Nothing.new
      end

      def reduce(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        raw.reduce do |acc, element|
          argument.call(
            arguments: [
              ::Code::Object::Argument.new(acc),
              ::Code::Object::Argument.new(element)
            ],
            context: context,
            io: io,
          )
        end || ::Code::Object::Nothing.new
      end

      def each(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        raw.each do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            context: context,
            io: io,
          )
        end
        self
      end

      def select(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        ::Code::Object::List.new(
          raw.select do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              context: context,
              io: io,
            ).truthy?
          end
        )
      end

      def map(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        ::Code::Object::List.new(
          raw.map do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              context: context,
              io: io,
            )
          end
        )
      end

      def append(arguments)
        sig(arguments, ::Code::Object)
        raw << arguments.first.value
        self
      end

      def first(arguments)
        sig(arguments)
        raw.first
      end

      def max(arguments)
        sig(arguments)
        raw.max || ::Code::Object::Nothing.new
      end

      def reverse(arguments)
        sig(arguments)
        ::Code::Object::List.new(raw.reverse)
      end

      def last(arguments)
        sig(arguments)
        raw.last
      end
    end
  end
end
