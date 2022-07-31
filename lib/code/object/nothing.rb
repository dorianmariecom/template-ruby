class Code
  class Object
    class Nothing < ::Code::Object
      attr_reader :raw

      def initialize
        @raw = nil
      end

      def truthy?
        false
      end

      def to_s
        ""
      end

      def inspect
        "nothing"
      end
    end
  end
end
