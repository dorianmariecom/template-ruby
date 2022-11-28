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
        globals = multi_fetch(args, *::Code::GLOBALS)
        value = arguments.first&.value

        if operator == "&" || operator == "to_function"
          sig(arguments)
          to_function(**globals)
        elsif operator == "+"
          sig(arguments) { ::Code::Object }
          plus(value)
        elsif operator == "*"
          sig(arguments) { ::Code::Object::Number }
          multiplication(value)
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
                parameters: [{ name: "_" }],
                body: [
                  {
                    chained_call: {
                      first: {
                        call: {
                          name: "_"
                        }
                      },
                      others: [{ call: { name: raw } }]
                    }
                  }
                ]
              }
            }
          ]
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
