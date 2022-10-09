class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])

        if operator == "to_function"
          to_function(arguments)
        elsif operator == "+"
          plus(arguments)
        elsif operator == "*"
          multiplication(arguments)
        elsif operator == "reverse"
          reverse(arguments)
        else
          super
        end
      end

      def succ
        ::Code::Object::String.new(raw.succ)
      end

      def to_sym
        raw.to_sym
      end

      def to_s
        raw
      end

      def inspect
        raw.inspect
      end

      private

      def to_function(arguments)
        sig(arguments)
        Code.evaluate("(_) => { _.#{raw} }")
      end

      def plus(arguments)
        sig(arguments, ::Code::Object)
        other = arguments.first.value
        ::Code::Object::String.new(raw + other.to_s)
      end

      def multiplication(arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::String.new(raw * other.raw)
      end

      def reverse(arguments)
        sig(arguments)
        ::Code::Object::String.new(raw.reverse)
      end
    end
  end
end
