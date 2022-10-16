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
        globals = args.slice(:context, :io)

        if operator == "any?"
          sig(arguments, ::Code::Object::Function)
          any?(arguments.first.value, **globals)
        elsif operator == "all?"
          sig(arguments, ::Code::Object::Function)
          all?(arguments.first.value, **globals)
        elsif operator == "each"
          sig(arguments, ::Code::Object::Function)
          each(arguments.first.value, **globals)
        elsif operator == "select"
          sig(arguments, ::Code::Object::Function)
          select(arguments.first.value, **globals)
        elsif operator == "map"
          sig(arguments, ::Code::Object::Function)
          map(arguments.first.value, **globals)
        elsif operator == "step"
          sig(arguments, ::Code::Object::Number)
          step(arguments.first.value)
        elsif operator == "to_list"
          sig(arguments)
          to_list
        elsif operator == "first"
          sig(arguments)
          first
        elsif operator == "last"
          sig(arguments)
          last
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

      def any?(argument, **globals)
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals
            ).truthy?
          end,
        )
      end

      def all?(argument, **globals)
        ::Code::Object::Boolean.new(
          raw.all? do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals
            ).truthy?
          end,
        )
      end

      def each(argument, **globals)
        raw.each do |element|
          argument.call(
            arguments: [::Code::Object::Argument.new(element)],
            **globals
          )
        end
        self
      end

      def select(argument, **globals)
        ::Code::Object::List.new(
          raw.select do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals
            ).truthy?
          end,
        )
      end

      def map(argument, **globals)
        ::Code::Object::List.new(
          raw.map do |element|
            argument.call(
              arguments: [::Code::Object::Argument.new(element)],
              **globals
            )
          end,
        )
      end

      def step(argument)
        list = ::Code::Object::List.new
        element = @left
        list << element

        if @exlucde_end
          while (element = element + argument) < @right
            list << element
          end
        else
          while (element = element + argument) <= @right
            list << element
          end
        end

        list
      end

      def to_list
        ::Code::Object::List.new(raw.to_a)
      end

      def first
        raw.first
      end

      def last
        raw.last
      end
    end
  end
end
