class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def call(arguments: [], context: ::Code::Object::Context.new, operator: nil)
        if operator == "to_function"
          to_function(arguments)
        elsif operator == "+"
          plus(arguments)
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
        sig(arguments, ::Code::Object::String)
        other = arguments.first.value
        ::Code::Object::String.new(raw + other.raw)
      end
    end
  end
end
