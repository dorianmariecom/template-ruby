class Code
  class Object
    class Integer < ::Code::Object::Number
      attr_reader :raw

      def initialize(whole, exponent: nil)
        @raw = whole.to_i

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

        if operator == "even?"
          even?(arguments)
        elsif operator == "to_string"
          code_to_s(arguments)
        elsif operator == "*"
          multiplication(arguments)
        elsif operator == "/"
          division(arguments)
        elsif %w[% - + **].detect { |o| operator == o }
          integer_or_decimal_operation(operator.to_sym, arguments)
        elsif %w[> >= < <=].detect { |o| operator == o }
          comparaison(operator.to_sym, arguments)
        elsif %w[<< >> & | ^].detect { |o| operator == o }
          integer_operation(operator.to_sym, arguments)
        else
          super
        end
      end

      def succ
        ::Code::Object::Integer.new(raw + 1)
      end

      def to_s
        raw.to_s
      end

      def inspect
        to_s
      end

      private

      def even?(arguments)
        sig(arguments)
        ::Code::Object::Boolean.new(raw.even?)
      end

      def code_to_s(arguments)
        sig(arguments)
        ::Code::Object::String.new(raw.to_s)
      end

      def multiplication(arguments)
        sig(arguments, [::Code::Object::Number, ::Code::Object::String])
        other = arguments.first.value
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw * other.raw)
        elsif other.is_a?(::Code::Object::Decimal)
          ::Code::Object::Decimal.new(raw * other.raw)
        else
          ::Code::Object::String.new(other.raw * raw)
        end
      end

      def division(arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Decimal.new(BigDecimal(raw) / other.raw)
      end

      def integer_or_decimal_operation(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        if other.is_a?(::Code::Object::Integer)
          ::Code::Object::Integer.new(raw.public_send(operator, other.raw))
        else
          ::Code::Object::Decimal.new(raw.public_send(operator, other.raw))
        end
      end

      def integer_operation(operator, arguments)
        sig(arguments, ::Code::Object::Integer)
        other = arguments.first.value
        ::Code::Object::Integer.new(raw.public_send(operator, other.raw))
      end

      def comparaison(operator, arguments)
        sig(arguments, ::Code::Object::Number)
        other = arguments.first.value
        ::Code::Object::Boolean.new(raw.public_send(operator, other.raw))
      end
    end
  end
end
