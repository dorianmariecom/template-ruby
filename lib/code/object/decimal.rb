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

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])

        if %w[% - + / * **].detect { |o| operator == o }
          number_operation(operator.to_sym, arguments)
        elsif %w[< <= > >=].detect { |o| operator == o }
          comparaison(operator.to_sym, arguments)
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

      def comparaison(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
      end
    end
  end
end
