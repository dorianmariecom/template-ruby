class Code
  class Object
    class Nothing < ::Code::Object
      def to_s
        ""
      end

      def inspect
        "nothing"
      end
    end
  end
end
