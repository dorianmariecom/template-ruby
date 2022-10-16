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
        globals = args.multi_fetch(*::Code::GLOBALS)

        if operator == "to_function"
          sig(arguments)
          to_function(**globals)
        elsif operator == "+"
          sig(arguments, ::Code::Object)
          plus(arguments.first.value)
        elsif operator == "*"
          sig(arguments, ::Code::Object::Number)
          multiplication(arguments.first.value)
        elsif operator == "reverse"
          sig(arguments)
          reverse
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

      def to_function(**globals)
        ::Code::Node::Code.new(
          [
            {
              function: {
                arguments: [{ regular: { name: "_" } }],
                body: [
                  { call: { left: { name: "_" }, right: [{ name: raw }] } },
                ],
              },
            },
          ],
        ).evaluate(**globals)
      end

      def plus(other)
        ::Code::Object::String.new(raw + other.to_s)
      end

      def multiplication(other)
        ::Code::Object::String.new(raw * other.raw)
      end

      def reverse
        ::Code::Object::String.new(raw.reverse)
      end
    end
  end
end
