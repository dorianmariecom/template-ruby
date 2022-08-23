class Code
  class Node
    class Base10Integer < Node
      def initialize(number)
        @sign = number[:sign]
        @whole = number.fetch(:whole)

        if number.key?(:exponent)
          @exponent = ::Code::Node::Base10Number.new(number[:exponent])
        end
      end

      def evaluate(**args)
        if @exponent
          exponent = @exponent.evaluate(**args)

          if exponent.is_a?(::Code::Object::Decimal)
            ::Code::Object::Decimal.new("#{sign}#{whole}", exponent: exponent)
          else
            ::Code::Object::Integer.new("#{sign}#{whole}", exponent: exponent)
          end
        else
          ::Code::Object::Integer.new("#{sign}#{whole}")
        end
      end

      private

      attr_reader :sign, :whole
    end
  end
end
