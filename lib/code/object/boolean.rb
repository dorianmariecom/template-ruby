class Code
  class Object
    class Boolean < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def truthy?
        raw
      end

      def succ
        ::Code::Object::Boolean.new(!raw)
      end

      def to_s
        raw.to_s
      end

      def inspect
        to_s
      end
    end
  end
end
