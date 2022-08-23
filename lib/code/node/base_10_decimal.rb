class Code
  class Node
    class Base10Decimal < Node
      def initialize(number)
        @sign = number[:sign]
        @whole = number.fetch(:whole)
        @decimal = number.fetch(:decimal)

        if number.key?(:exponent)
          @exponent = ::Code::Node::Base10Number.new(number[:exponent])
        end
      end

      def evaluate(**args)
        if @exponent
          exponent = @exponent.evaluate(**args)

          ::Code::Object::Decimal.new(
            "#{sign}#{whole}.#{decimal}",
            exponent: exponent,
          )
        else
          ::Code::Object::Decimal.new("#{sign}#{whole}.#{decimal}")
        end
      end

      private

      attr_reader :sign, :whole, :decimal
    end
  end
end
