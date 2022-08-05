class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def evaluate(key, *args, **kargs)
        if key == :+
          string_operation(key, args.first)
        else
          super
        end
      end

      def succ
        ::Code::Object::String.new(raw.succ)
      end

      def to_s
        raw
      end

      def inspect
        raw.inspect
      end

      private

      def string_operation(operator, other)
        if other.is_a?(::Code::Object::String)
          ::Code::Object::String.new(raw.public_send(operator, other.raw))
        else
          raise ::Code::Error::TypeError.new(
                  "#{operator} only supports strings",
                )
        end
      end
    end
  end
end
