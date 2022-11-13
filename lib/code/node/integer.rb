class Code
  class Node
    class Integer < Node
      def initialize(parsed)
        @integer = parsed
      end

      def evaluate(**args)
        ::Code::Object::Integer.new(@integer)
      end
    end
  end
end
