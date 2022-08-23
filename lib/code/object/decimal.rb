class Code
  class Object
    class Decimal < ::Code::Object::Number
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)

        if exponent
          if exponent.is_a?(::Code::Object::Number)
            @raw = @raw * 10**exponent.raw
          else
            raise ::Code::Error::TypeError.new("exponent is not a number")
          end
        end
      end

      def call(
        arguments: [],
        context: ::Code::Object::Context.new,
        operator: nil
      )
        if ["%", "-", "+", "/", "*"].find(operator)
          number_operation(operator.to_sym, arguments)
        else
          super
        end
      end

      def to_s
        raw.to_s("F")
      end

      def inspect
        to_s
      end

      private

      def number_operation(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Decimal.new(raw.public_send(operator, other.raw))
      end
    end
  end
end
