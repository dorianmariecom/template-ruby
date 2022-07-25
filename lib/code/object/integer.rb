class Code
  class Object
    class Integer < ::Code::Object
      attr_reader :raw

      def initialize(whole, exponent: nil)
        @raw = whole.to_i
        @raw = @raw * 10 ** exponent.raw if exponent
      end

      def to_s
        raw.to_s
      end
    end
  end
end
