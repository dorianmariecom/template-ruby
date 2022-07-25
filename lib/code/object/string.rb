require "bigdecimal"

class Code
  class Object
    class String < ::Code::Object
      def initialize(string)
        @raw = string
      end

      def to_s
        raw
      end

      private

      attr_reader :raw
    end
  end
end
