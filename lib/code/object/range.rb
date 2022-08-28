class Code
  class Object
    class Range < ::Code::Object
      attr_reader :raw

      def initialize(left, right, exclude_end: false)
        @left = left
        @right = right
        @exclude_end = exclude_end
        @raw = ::Range.new(left, right, exclude_end)
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)

        if operator == "any?"
          any?(arguments, context: context, io: io)
        elsif operator == "all?"
          all?(arguments, context: context, io: io)
        elsif operator == "each"
          each(arguments, context: context, io: io)
        elsif operator == "select"
          select(arguments, context: context, io: io)
        elsif operator == "map"
          map(arguments, context: context, io: io)
        elsif operator == "step"
          step(arguments)
        elsif operator == "to_list"
          to_list(arguments)
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
        argument = arguments.first.value
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            argument
              .call(
                arguments: [::Code::Object::Argument.new(element)],
                context: context,
                io: io,
              )
              .truthy?
          end,
        )
      end

      def all?(arguments, context:, io:)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first.value
        ::Code::Object::Boolean.new(
          raw.all? do |element|
            argument
              .call(
                arguments: [::Code::Object::Argument.new(element)],
                context: context,
                io: io,
              )
              .truthy?
          end,
        )
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

      def step(arguments)
        sig(arguments, ::Code::Object::Number)
        argument = arguments.first.value

        list = ::Code::Object::List.new
        element = @left
        list << element

        if @exlucde_end
          list << element while (element = element + argument) < @right
        else
          list << element while (element = element + argument) <= @right
        end

        list
      end

      def to_list(arguments)
        sig(arguments)
        ::Code::Object::List.new(raw.to_a)
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
