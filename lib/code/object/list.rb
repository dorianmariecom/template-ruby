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
        globals = args.slice(:context, :io)

        if operator == "any?"
          sig(arguments, ::Code::Object::Function)
          any?(arguments.first.value, **globals)
        elsif operator == "none?"
          sig(arguments, ::Code::Object::Function)
          none?(arguments.first.value, **globals)
        elsif operator == "detect"
          sig(arguments, ::Code::Object::Function)
          detect(arguments.first.value, **globals)
        elsif operator == "reduce"
          sig(arguments, ::Code::Object::Function)
          reduce(arguments.first.value, **globals)
        elsif operator == "each"
          sig(arguments, ::Code::Object::Function)
          each(arguments.first.value, **globals)
        elsif operator == "select"
          sig(arguments, ::Code::Object::Function)
          select(arguments.first.value, **globals)
        elsif operator == "map"
          sig(arguments, ::Code::Object::Function)
          map(arguments.first.value, **globals)
        elsif operator == "max_by"
          sig(arguments, ::Code::Object::Function)
          max_by(arguments.first.value, **globals)
        elsif operator == "max"
          sig(arguments)
          max
        elsif operator == "flatten"
          sig(arguments)
          flatten
        elsif operator == "reverse"
          sig(arguments)
          reverse
        elsif operator == "first"
          sig(arguments)
          first
        elsif operator == "last"
          sig(arguments)
          last
        elsif operator == "<<"
          sig(arguments, ::Code::Object)
          append(arguments.first.value)
        else
          super
        end
      end

      def flatten
        ::Code::Object::List.new(
          raw.reduce([]) do |acc, element|
            if element.is_a?(::Code::Object::List)
              acc + element.flatten.raw
            else
              acc + [element]
            end
          end,
        )
      end

      def deep_dup
        ::Code::Object::List.new(raw.deep_dup)
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
      end

      def inspect
        to_s
      end

      private

      def any?(argument, **globals)
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals,
            ).truthy?
          end,
        )
      end

      def none?(argument, **globals)
        ::Code::Object::Boolean.new(
          raw.none? do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals,
            ).truthy?
          end,
        )
      end

      def max_by(argument, **globals)
        raw.max_by do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            **globals,
          )
        end || ::Code::Object::Nothing.new
      end

      def detect(argument, **globals)
        raw.detect do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            **globals,
          ).truthy?
        end || ::Code::Object::Nothing.new
      end

      def reduce(argument, **globals)
        raw.reduce do |acc, element|
          argument.call(
            arguments: [
              ::Code::Object::Argument.new(acc),
              ::Code::Object::Argument.new(element),
            ],
            **globals,
          )
        end || ::Code::Object::Nothing.new
      end

      def each(argument, **globals)
        raw.each do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            **globals,
          )
        end
        self
      end

      def select(argument, **globals)
        ::Code::Object::List.new(
          raw.select do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals,
            ).truthy?
          end,
        )
      end

      def map(argument, context:, io:)
        ::Code::Object::List.new(
          raw.map do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals,
            )
          end,
        )
      end

      def append(other)
        raw << other
        self
      end

      def first
        raw.first || ::Code::Object::Nothing.new
      end

      def max
        raw.max || ::Code::Object::Nothing.new
      end

      def reverse
        ::Code::Object::List.new(raw.reverse)
      end

      def last
        raw.last || ::Code::Object::Nothing.new
      end
    end
  end
end
