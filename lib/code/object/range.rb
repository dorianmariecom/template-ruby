class Code
  class Object
    class Range < ::Code::Object
      attr_reader :raw

      def initialize(left, right, exclude_end: false)
        @raw = ::Range.new(left, right, exclude_end)
      end

      def call(arguments: [], context: ::Code::Object::Dictionnary.new, operator: nil)
        if operator == "any?"
          any?(arguments)
        elsif operator == "each"
          each(arguments)
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

      def any?(arguments)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            simple_call(argument.value, nil, element).truthy?
          end
        )
      end

      def each(arguments)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        raw.each do |element|
          simple_call(argument.value, nil, element)
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
