class Code
  class Node
    class Base16 < Node
      def initialize(parsed)
        @base_16 = parsed
      end

      def evaluate(**args)
        ::Code::Object::Integer.new(@base_16.to_i(16))
      end
    end
  end
end
