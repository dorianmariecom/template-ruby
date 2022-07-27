class Code
  class Object
    class List < ::Code::Object
      def initialize(raw)
        @raw = raw
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
      end

      def inspect
        to_s
      end

      private

      attr_reader :raw
    end
  end
end
