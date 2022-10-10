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

        if %w[% - / * **].detect { |o| operator == o }
          number_operation(operator.to_sym, arguments)
        elsif %w[< <= > >=].detect { |o| operator == o }
          comparaison(operator.to_sym, arguments)
        elsif %w[<< >> & | ^].detect { |o| operator == o }
          integer_operation(operator.to_sym, arguments)
        elsif operator == "+"
          plus(arguments)
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

      def integer_operation(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Integer.new(raw.to_i.public_send(operator, other.raw.to_i))
      end

      def comparaison(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
      end

      def plus(arguments)
        sig(arguments, ::Code::Object)
        other = arguments.first.value

        if other.is_a?(::Code::Object::Number)
          ::Code::Object::Decimal.new(raw + other.raw)
        else
          ::Code::Object::String.new(to_s + other.to_s)
        end
      end
    end
  end
end
