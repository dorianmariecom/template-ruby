class Code
  class Object
    class Boolean < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def evaluate(key, *args, **kargs)
        super
      end

      def truthy?
        raw
      end

      def succ
        new(!raw)
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
