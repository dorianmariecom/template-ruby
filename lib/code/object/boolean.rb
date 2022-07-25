class Code
  class Object
    class Boolean < ::Code::Object
      def initialize(raw)
        @raw = raw
      end

      def to_s
        @raw.to_s
      end
    end
  end
end
