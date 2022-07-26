require "bigdecimal"

class Code
  class Object
    class Decimal < ::Code::Object
      attr_reader :raw

      def initialize(decimal, exponent: nil)
        @raw = BigDecimal(decimal)
        @raw = @raw * 10**exponent.raw if exponent
      end

      def to_s
        raw.to_s("F")
      end
    end
  end
end
