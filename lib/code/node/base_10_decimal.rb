class Code
  class Node
    class Base10Decimal
      def initialize(number)
        @sign = number[:sign]
        @whole = number.fetch(:whole)
        @decimal = number.fetch(:decimal)

        if number.key?(:exponent)
          @exponent = ::Code::Node::Base10Number.new(number[:exponent])
        end
      end

      def evaluate(context)
        @exponent = @exponent.evaluate(context) if @exponent
        ::Code::Object::Decimal.new(
          "#{sign}#{whole}.#{decimal}",
          exponent: @exponent
        )
      end

      private

      attr_reader :sign, :whole, :decimal
    end
  end
end
