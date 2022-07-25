class Code
  class Node
    class Base10Integer
      def initialize(number)
        @sign = number[:sign]
        @whole = number.fetch(:whole)

        if number.key?(:exponent)
          @exponent = ::Code::Node::Base10Number.new(number[:exponent])
        end
      end

      def evaluate(context)
        @exponent = @exponent.evaluate(context) if @exponent
        ::Code::Object::Integer.new("#{sign}#{whole}", exponent: @exponent)
      end

      private

      attr_reader :sign, :whole
    end
  end
end
